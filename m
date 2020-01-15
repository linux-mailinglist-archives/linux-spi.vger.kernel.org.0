Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82F313B95F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 07:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgAOGNx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 01:13:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58618 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOGNw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 01:13:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00F6DU9g079483;
        Wed, 15 Jan 2020 00:13:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579068810;
        bh=6ErZheo3CWGhZ2ZZ3TOwWdBo8wbw7aegRQVfbsnMC+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cSn9hQGbSJKA7g/x0S69FYOMVzXf5biDoRCFijkk84skr8qLLAG4y9KjOadmp6+hc
         p5MbEAntSqWiB49+rUwlK4dGTvaClGgPKURPdU/qgALIuZ7x+UKjsoBkPATlFsDlbm
         +rDrGC4g8Jdv7vIxlG340MV90YFZgcwNr8mM4N14=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00F6DUtc101258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jan 2020 00:13:30 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 15
 Jan 2020 00:13:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 15 Jan 2020 00:13:30 -0600
Received: from [10.250.133.94] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00F6DQ3R023371;
        Wed, 15 Jan 2020 00:13:27 -0600
Subject: Re: [PATCH v6 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <860aecbc-22d3-c9ce-3570-44115d6e81b2@ti.com>
Date:   Wed, 15 Jan 2020 11:43:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 12/30/2019 1:11 PM, Ramuthevar,Vadivel MuruganX wrote:
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
> 



I am finally able to get spi-mem based cadence-quaspi driver working on
TI platforms with DMA and DAC mode. I have also incorporated changes to
disable DAC and autopolling for your intel SoC:

https://github.com/r-vignesh/linux/commits/qspi

(Top two patches are of interest)

I have tested both DAC and INDAC mode with s25fl flash and everything
seems to be fine. Could you re test the driver on your SoC? Feel free to
fold it into your series if everything works.

Regards
Vignesh



