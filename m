Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9730440F5C7
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhIQKWP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 06:22:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40884 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhIQKWO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 06:22:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18HAKnfg085552;
        Fri, 17 Sep 2021 05:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631874049;
        bh=VLm4UxwbbuEzVUE70aWdz5RD8bv6XF2EJwP+insnRhM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=OqNp2nxItL3bQWAwT3wpC/o4J+vwLWsmZs4o9IrUhlpCXCZ7oEVkt1VgnyjLzLryI
         KcSW0JksYR9G/oBOLrYBCxDmMy1QeQtd6vtjKPxjkjQALIg3cTiO5KPei21Lw1ZiyV
         QoCvuIUB72dxwwM/9UBfkK4ZhhBS8K+9D892lqoc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18HAKn1D056993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Sep 2021 05:20:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Sep 2021 05:20:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Sep 2021 05:20:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18HAKmfA104639;
        Fri, 17 Sep 2021 05:20:49 -0500
Date:   Fri, 17 Sep 2021 15:50:47 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Parshuram Thombare <pthombar@cadence.com>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Konrad Kociolek <konrad@cadence.com>
Subject: Re: [PATCH v4 2/2] spi: cadence: add support for Cadence XSPI
 controller
Message-ID: <20210917102045.mapb7j3sixzxwald@ti.com>
References: <1631534558-8102-1-git-send-email-pthombar@cadence.com>
 <1631534779-8371-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1631534779-8371-1-git-send-email-pthombar@cadence.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/09/21 02:06PM, Parshuram Thombare wrote:
> This patch adds driver for Cadence's XSPI controller.
> It supports 3 work modes.
> 1. ACMD (auto command) work mode
>     ACMD name is because it uses auto command engine in the controller.
>     It further has 2 modes PIO and CDMA (command DMA).
>     The CDMA work mode is dedicated for high-performance application
>     where very low software overhead is required. In this mode the
>     Command Engine is programmed by the series of linked descriptors
>     stored in system memory. These descriptors provide commands to execute
>     and store status information for finished commands.
>     The PIO mode work mode is dedicated for single operation where
>     constructing a linked list of descriptors would require too
>     much effort.
> 2. STIG (Software Triggered Instruction Generator) work mode
>     In STIG mode, controller sends low-level instructions to memory.
>     Each instruction is 128-bit width. There is special instruction
>     DataSequence which carries information about data phase.
>     Driver uses Slave DMA interface to transfer data as only this
>     interface can be used in STIG work mode.
> 3. Direct work mode
>     This work mode allows sending data without invoking any command through
>     the slave interface.
> Currently only STIG work mode is enabled, remaining work modes will
> be added later.

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
