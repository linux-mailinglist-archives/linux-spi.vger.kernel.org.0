Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F4163F03
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgBSI2P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Feb 2020 03:28:15 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:51201 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgBSI2O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Feb 2020 03:28:14 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48MrT83SH2z1rt3V;
        Wed, 19 Feb 2020 09:28:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48MrT823Fzz1qwyt;
        Wed, 19 Feb 2020 09:28:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MGlAbeC1-J_T; Wed, 19 Feb 2020 09:28:10 +0100 (CET)
X-Auth-Info: Vssf82laU1VwDmXI1+NEHx9u0Tbm99V4VHUGFkTohuI=
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 19 Feb 2020 09:28:10 +0100 (CET)
Subject: Re: [PATCH v10 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com
Cc:     robh+dt@kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <8b6c9a13-928a-9e9f-d5e2-e7320efc2a2f@denx.de>
Date:   Wed, 19 Feb 2020 09:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/19/20 3:28 AM, Ramuthevar,Vadivel MuruganX wrote:
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
> 
> This driver does not support generic SPI and also the implementation
> only supports spi-mem interface to replace the existing driver in
> mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
> flash memory.
> 
> Thanks Mark and Vignesh for the review, suggestion to optimize the patch.
> Tested with mx25u12835f on LGM platform.

There is a typo in the subject -- it's quadspi , not quadpsi.
