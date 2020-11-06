Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D382A8E7A
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 05:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgKFEns (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 23:43:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:15177 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFEnr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 23:43:47 -0500
IronPort-SDR: 4ebYAZVL9d3eS0KmvT7tZixbW13Gvq0oM2TrvMvKOjFC6S6F68r5dvoxe59+EvhzsSAChqUHQD
 ipYbCeQbGJSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="165991804"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="165991804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 20:43:47 -0800
IronPort-SDR: A8wwO5mdzozqG58eqr5nBl8RN78TcBBXoF5GwHVYMhWRx3h2D9KWerFQACbRWZ+sl90QXoP1IG
 VgL0tGRQ2SCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="364057875"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2020 20:43:46 -0800
Received: from [10.215.162.127] (vramuthx-MOBL1.gar.corp.intel.com [10.215.162.127])
        by linux.intel.com (Postfix) with ESMTP id 270AC580841;
        Thu,  5 Nov 2020 20:43:42 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v5 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201029062014.27620-6-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CACRpkdaz9E2yc3GnN8wus3M+qQRknW2QMe8Kn-=o=czOQf7A-Q@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <280623e3-d182-60f3-5588-96d00e573694@linux.intel.com>
Date:   Fri, 6 Nov 2020 12:43:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaz9E2yc3GnN8wus3M+qQRknW2QMe8Kn-=o=czOQf7A-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 5/11/2020 3:14 pm, Linus Walleij wrote:
> On Thu, Oct 29, 2020 at 8:39 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> 
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
>> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
>> +  cdns,is-decoded-cs:
>> +    type: boolean
>> +    description:
>> +      Flag to indicate whether decoder is used or not.
> 
> Please elaborate a bit on what kind of decoder this is.
> I am curious! :)
Sure, I will elaborate more about decoder for chip select.

QSPI controller has in-built chip select decoder instead of external 
decder circuit, it supports multiple chip selection by 2-to-4 decoder, 
the below combinations
CS0 - 1110
CS1 - 1101
CS2 - 1011
CS3 - 0111

when in direct access mode, each chip selection has it's own specified 
memory region as well.

Regards
Vadivel
> 
> Yours,
> Linus Walleij
> 
