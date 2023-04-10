/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
function generateBid(interestGroup, auctionSignals, perBuyerSignals, trustedBiddingSignals, browserSignals) {
  console.log("In generateBid: trustedBiddingSignals: ", trustedBiddingSignals);
  const [testAd] = interestGroup.ads;

  var budget = 1;
  if ("budget" in trustedBiddingSignals) {
    console.log("trustedBiddingSignals returned budget ", trustedBiddingSignals["budget"], ". Using that as bid.");
    budget = Number(trustedBiddingSignals["budget"]);
  }else {
    console.log("Using default bid: 1");
  }
  var bidOutput = {
    bid: budget,
    ad: {
      adName: testAd.metadata.adName,
    },
    render: testAd.renderUrl,
  };
  console.log("In generateBid: final output: ", bidOutput);
  return bidOutput;
}

function reportWin() {
  console.log('report win');
}
