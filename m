Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB2D406D55
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhIJOMh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 10:12:37 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:8624 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233702AbhIJOMg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 10:12:36 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A6UI7r018935;
        Fri, 10 Sep 2021 09:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Tjo1b/f4UDI2qPHaSD4AUkLYHrkga4Eyry3mj3JPrr4=;
 b=LO8UDqCqzmj47Y30yfZYSPBJX3E8lmiEJaSmJg8p1p+v7r3CGhpwANLwIPPLHCVllAL2
 4NAdhfUZX08BXBLHVnnUCCb1KuHwp4FE8pc1NsfHjhaND8MySnAfufP6gl3pHQQY5pc+
 nXJh5XN9NITrHtBNK6S2+HgLrltUhBkwLja0ID3brnOlyNWlHaDtmyP188Bxga1Flx4D
 5dGMOEjzBE39BkqKNvkC7lsSdgtKaoZaD+Iyg8KwXpS+kbSLAtyZBaiKx7DdVEnmlTjj
 /vzpPErwJaOIPCrHz8dw9fINIxSXOZqUAciMzf1H9b11WV8YZS81AbWIEFFeJ4Kc6++K 4Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3aytg7926j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 09:11:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 15:11:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 15:11:13 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D8A3DB10;
        Fri, 10 Sep 2021 14:11:12 +0000 (UTC)
Date:   Fri, 10 Sep 2021 14:11:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 4/4] spi: amd: Don't wait for a write-only transfer to
 finish
Message-ID: <20210910141112.GZ9223@ediswmail.ad.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
 <20210910111529.12539-4-tanureal@opensource.cirrus.com>
 <20210910124223.GY9223@ediswmail.ad.cirrus.com>
 <790250e3-a928-57d4-1378-bc8923163452@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <790250e3-a928-57d4-1378-bc8923163452@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: EWhzBsSsU4K3t9naDZjM4lvSNVFx_5_Q
X-Proofpoint-ORIG-GUID: EWhzBsSsU4K3t9naDZjM4lvSNVFx_5_Q
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 10, 2021 at 02:47:32PM +0100, Lucas tanure wrote:
> On 9/10/21 1:42 PM, Charles Keepax wrote:
> >On Fri, Sep 10, 2021 at 12:15:29PM +0100, Lucas Tanure wrote:
> >>Return from a write-only transfer without waiting for
> >>it to finish
> >>But wait before a new transfer as the previous may
> >>still happening and also wait before reading the data
> >>from the FIFO
> >>
> >>Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> >>---
> >>  static int amd_spi_master_setup(struct spi_device *spi)
> >>@@ -178,6 +185,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
> >>  			amd_spi_clear_fifo_ptr(amd_spi);
> >>  			/* Execute command */
> >>  			amd_spi_execute_opcode(amd_spi);
> >>+			amd_spi_busy_wait(amd_spi);
> >
> >Surely the previous transfer can't still be happening if this if
> >unconditional? Should this not be gated on rx_len?
> >
> >Thanks,
> >Charles
> >
> >>  			/* Read data from FIFO to receive buffer  */
> >>  			for (i = 0; i < rx_len; i++)
> >>  				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
> >>-- 
> >>2.33.0
> >>
> This is executed inside an xfer->rx_buf not null if, so it`s gated
> in a read transfer and not for a write transfer only
> 

And so it is, sorry should have looked at more than just the git
context there.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
