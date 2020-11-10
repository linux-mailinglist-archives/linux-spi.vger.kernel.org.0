Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8F2ACEE9
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 06:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKJFWI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 00:22:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:14169 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJFWI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Nov 2020 00:22:08 -0500
IronPort-SDR: XNZneKVzzXCdJ/aDKfJj/CfQDNx08k4TTXs3pScLHpd3u7Ykw4HkkVzIlM1J8eVlqdMHBGV7Xh
 UlaTy2AuDs8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="170031220"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="170031220"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 21:22:06 -0800
IronPort-SDR: WvKkWCVPylQZuUBwqWgTz4jFmT03PWdK4j7aN3ikzyWfkcgQ4K0cZzJciF50dMdcXd4QLicVlX
 gCT5f9EQzSvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="541186913"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2020 21:22:05 -0800
Received: from [10.255.131.216] (vramuthx-MOBL1.gar.corp.intel.com [10.255.131.216])
        by linux.intel.com (Postfix) with ESMTP id DD8AB580AE3;
        Mon,  9 Nov 2020 21:22:00 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201104220321.GB4192737@bogus>
 <12deb9bb-6b3b-d71b-0a6e-5b58da23e09d@linux.intel.com>
 <CAL_JsqLh=zGiaVaT2nyJjRDLnryR1ZNbK2D=0+MO4Lb=q--yDw@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <9692dcf4-b99c-cac0-a126-5fadc9501902@linux.intel.com>
Date:   Tue, 10 Nov 2020 13:21:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLh=zGiaVaT2nyJjRDLnryR1ZNbK2D=0+MO4Lb=q--yDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 9/11/2020 11:15 pm, Rob Herring wrote:
> On Sun, Nov 8, 2020 at 7:49 PM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>
>> Hi Rob,
>>
>> On 5/11/2020 6:03 am, Rob Herring wrote:
>>> On Fri, Oct 30, 2020 at 01:31:53PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> Add compatible for Intel LGM SoC.
>>>>
>>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>>>> index ec22b040d804..58ecdab939df 100644
>>>> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>>>> @@ -19,6 +19,7 @@ properties:
>>>>              - enum:
>>>>                  - ti,k2g-qspi
>>>>                  - ti,am654-ospi
>>>> +              - intel,lgm-qspi
>>>
>>> As this change shows, you don't need 'oneOf' for Intel...
>> As we you have suggested in the previous mail, I framed like below with
>> 'oneOf'
>>
>> properties:
>>     compatible:
>>       oneOf:
>>         - items:
>>             - enum:
>>                 - ti,k2g-qspi
>>                 - ti,am654-ospi
>>             - const: cdns,qspi-nor
>>
>>         - items:
>>             - enum:
>>                 - intel,lgm-qspi
>>                 - cadence,qspi   #compatible for generic in future use
> 
> Why are you not using the documented vendor prefix 'cdns'?
old document file name is cadence-quadspi.txt, so thought of keeping the 
same name.
Thank you for the suggestion, Sure, I will use it.
> 
> In any case, adding this is pointless. Your 'generic' compatible is below.
> 
> And you still don't need 'oneOf' here. The enum contents here can be
> in the first 'enum'.
Ok, Noted.

Regards
Vadivel
> 
>>             - const: cdns,qspi-nor
>>
>> so that ignoring error message warning can be avoided as well, Thanks!
> 
> In the example? Fix the example!
> 
> 
> Rob
> 
