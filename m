Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B3403A83
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhIHNXb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 09:23:31 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33784 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234910AbhIHNX3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 09:23:29 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1884TnH1007175;
        Wed, 8 Sep 2021 08:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=SxBOvLYfYx/9TZi7mUdm9bpPX0VMCLsfnj2n7UQS6fE=;
 b=p92LAVocQcwRQz+7rzi69BbZzC2Ys4gmigc+IOEmXPD78BN0wJqxUVQJdLz2HYEkF6aw
 tXnevxs7TWi5Vp0+8baEithmIBwt3AWi3vvhN91ePKrByA+BoCYZCd2VbdJyw4R3dNwx
 wVnBjJJ3UZ6CK//157nWD0XohL86QLIIVAMy60IOpS7Fx35Lqlm0PEPxr2Ne+5BghAtr
 HlrRVmNi4A5+GQSIFsyi83az97/vSF3lzkLB+bLXbR/MlJ0ECeQg5u/7v0UQB+5FfK7N
 q8cC0OxUONz9NaJzgQDL/cT0sLet6BiTOMtISJ8C5al0KN01VSJNUlA3gXaQzr7UXDuf HQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3axcp61mf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 08:22:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 14:22:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 14:22:16 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C8E01478;
        Wed,  8 Sep 2021 13:22:16 +0000 (UTC)
Date:   Wed, 8 Sep 2021 13:22:16 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 08/10] spi: amd: Fill FIFO buffer with the whole message
Message-ID: <20210908132216.GR9223@ediswmail.ad.cirrus.com>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
 <20210908113450.788452-9-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210908113450.788452-9-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: lmFdCiQO36vcVKgBXuZZ-eHcNuTJxaNa
X-Proofpoint-GUID: lmFdCiQO36vcVKgBXuZZ-eHcNuTJxaNa
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 08, 2021 at 12:34:49PM +0100, Lucas Tanure wrote:
> The controller is half-duplex, in that it cannot
> read data while it is sending data. But the FIFO
> is full-duplex, the writes and reads must be
> queued and executed together, and the read data
> will be offset in the FIFO by the length of the
> initial write data (as it would in a full-duplex
> SPI).
> 
> And the controller has an automatic CS which can
> only be activated during the transmission of the
> FIFO, which can make read|write data lose meaning
> as the CS will be toggle after the required
> read|write address.
> To avoid that set the max transfer and message
> size as AMD_SPI_FIFO_SIZE ensuring that incoming
> messages always fit inside a FIFO buffer
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Its only really this change I think that depends relates to the regmap/SPI
changes, it might be worth doing a separate series with the trivial
improvements to the SPI driver. As that allow that to get merged
quickly, and makes the series more focused and easy to review on
the more complex part of supporting the SPI hardwares weird CS/message
length quirk.

Thanks,
Charles
