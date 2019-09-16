Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAAB3F43
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfIPQuZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 12:50:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44384 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfIPQuZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Sep 2019 12:50:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8GGoD3u102130;
        Mon, 16 Sep 2019 11:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568652613;
        bh=2b+w9YQph1a1K5kZUWKsHKuOd7pfACGRDbksa+TkdRA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vcs6M85/gkrahpmIhP8LXX5RRffBwcmVWBNDm/YyoHWEFwOxImOtxAX3sJVVTcFtX
         MirJnkKSzhTO7feL4Yc3NN917rGaDcSco+It5/pMKFX+NDOzu0xoPCaoxVHXXa5X0V
         jltRnOf/nMpsl9kWvHBIZRB29tnqUXyhkxAndAj8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8GGoDwl039666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Sep 2019 11:50:13 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 16
 Sep 2019 11:50:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 16 Sep 2019 11:50:13 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8GGo9Cv058421;
        Mon, 16 Sep 2019 11:50:10 -0500
Subject: Re: [PATCH v1 0/2] spi: cadence-qspi: Add cadence-qspi support for
 Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>, <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cheol.yong.kim@intel.com>,
        <qi-ming.wu@intel.com>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c4555df5-89d5-e8a6-bed4-887c23ac4f0f@ti.com>
Date:   Mon, 16 Sep 2019 22:20:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On 16/09/19 1:08 PM, Ramuthevar,Vadivel MuruganX wrote:
> patch 1: Add YAML for cadence-qspi devicetree cdocumentation.
> patch 2: cadence-qspi controller driver to support QSPI-NAND flash
> using existing spi-nand framework with legacy spi protocol.

Nope, you cannot have two drivers for the same IP (i.e Cadence QSPI)
just to support to different types of SPI memories. This is the reason
why spi_mem_ops was introduced.

Please rewrite this driver over to use spi_mem_ops (instead of using
generic SPI xfers) so that same driver supports both SPI-NOR and
SPI-NAND flashes. Once that's done drivers/mtd/spi-nor/cadence-quadspi.c
can be deleted.

There are few existing examples of spi_mem_ops users in drivers/spi/
(git grep spi_mem_ops) and materials here on how to write such a driver:

[1]
https://bootlin.com/blog/spi-mem-bringing-some-consistency-to-the-spi-memory-ecosystem/
[2] https://www.youtube.com/watch?v=PkWbuLM_gmU

> 
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
>   spi: cadence-qspi: Add QSPI support for Intel LGM SoC
> 
>  .../devicetree/bindings/spi/cadence,qspi-nand.yaml |  84 +++
>  drivers/spi/Kconfig                                |   9 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-cadence-qspi-apb.c                 | 644 +++++++++++++++++++++
>  drivers/spi/spi-cadence-qspi-apb.h                 | 174 ++++++
>  drivers/spi/spi-cadence-qspi.c                     | 461 +++++++++++++++
>  drivers/spi/spi-cadence-qspi.h                     |  73 +++
>  7 files changed, 1446 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
>  create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
>  create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
>  create mode 100644 drivers/spi/spi-cadence-qspi.c
>  create mode 100644 drivers/spi/spi-cadence-qspi.h
> 

-- 
Regards
Vignesh
