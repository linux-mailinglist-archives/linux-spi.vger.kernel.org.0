Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6962AAED3
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 02:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgKIBtr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 8 Nov 2020 20:49:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:18410 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgKIBtr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 8 Nov 2020 20:49:47 -0500
IronPort-SDR: BM1AGjrYzDMAGbOrxgq46qbdaODHkWwj+s4p+Zpy66ei6/zbk8h4MJK4xTBee1wrO1vBd9gCn7
 hJ88H06a9spQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169850568"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="169850568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 17:49:46 -0800
IronPort-SDR: mc73/uhYoWhYM70tMCojdVsZFFyppQDXmvyv45t6fdHgfh8bHovRdMtfwsRy6tDgH+Jk0iU5hO
 BaLxi8zkbZPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="338203731"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Nov 2020 17:49:46 -0800
Received: from [10.213.33.64] (vramuthx-MOBL1.gar.corp.intel.com [10.213.33.64])
        by linux.intel.com (Postfix) with ESMTP id E9A1A580870;
        Sun,  8 Nov 2020 17:49:42 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v6 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201104220321.GB4192737@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <12deb9bb-6b3b-d71b-0a6e-5b58da23e09d@linux.intel.com>
Date:   Mon, 9 Nov 2020 09:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201104220321.GB4192737@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On 5/11/2020 6:03 am, Rob Herring wrote:
> On Fri, Oct 30, 2020 at 01:31:53PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add compatible for Intel LGM SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> index ec22b040d804..58ecdab939df 100644
>> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
>> @@ -19,6 +19,7 @@ properties:
>>             - enum:
>>                 - ti,k2g-qspi
>>                 - ti,am654-ospi
>> +              - intel,lgm-qspi
> 
> As this change shows, you don't need 'oneOf' for Intel...
As we you have suggested in the previous mail, I framed like below with 
'oneOf'

properties:
   compatible:
     oneOf:
       - items:
           - enum:
               - ti,k2g-qspi
               - ti,am654-ospi
           - const: cdns,qspi-nor

       - items:
           - enum:
               - intel,lgm-qspi
               - cadence,qspi   #compatible for generic in future use
           - const: cdns,qspi-nor

so that ignoring error message warning can be avoided as well, Thanks!


Regards
Vadivel

> 
>>             - const: cdns,qspi-nor
>>   
>>     reg:
>> -- 
>> 2.11.0
>>
