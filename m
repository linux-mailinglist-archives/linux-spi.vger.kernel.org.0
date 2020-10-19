Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EA292277
	for <lists+linux-spi@lfdr.de>; Mon, 19 Oct 2020 08:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgJSGXK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 02:23:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:53538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJSGXK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 02:23:10 -0400
IronPort-SDR: LwA7XxHDLwe1TnEW2Lye60tsNFghm1ELKinsTSvbrP+8nNGG/luEcT5f0yqbzuRqetrbt39lgF
 7IO1oi57A05g==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146836239"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="146836239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 23:23:04 -0700
IronPort-SDR: WijY2TQCLEfpUw0fX8sEtdIPCeJugv1LtVcbw8O6+yYh+fZ8gXiyqiey5OntJ5Ws6UVoHtDb6R
 xuZYyPTYSA5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="521892306"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2020 23:23:02 -0700
Received: from [10.226.38.24] (vramuthx-MOBL1.gar.corp.intel.com [10.226.38.24])
        by linux.intel.com (Postfix) with ESMTP id 68A6B5808A3;
        Sun, 18 Oct 2020 23:22:59 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 2/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
To:     Mark Brown <broonie@kernel.org>
Cc:     vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        miquel.raynal@bootlin.com, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, richard@nod.at, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016093138.28871-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201016161844.GH5274@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <1afb6b7a-94ec-b324-99f3-4c4d4529e581@linux.intel.com>
Date:   Mon, 19 Oct 2020 14:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201016161844.GH5274@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 17/10/2020 12:18 am, Mark Brown wrote:
> On Fri, Oct 16, 2020 at 05:31:34PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
>> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> 
> Please make YAML conversions the last thing in any patch series -
> there's sometimes a backlog on reviews as the DT maintainers are very
> busy so this means that delays with them don't hold the rest of the
> series up.
Thank you for the comment and suggestions...
Sure, will do that accordingly.

Regards
Vadivel
> 
