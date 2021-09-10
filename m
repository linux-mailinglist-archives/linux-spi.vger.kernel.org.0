Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01A74068B6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhIJIuL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 04:50:11 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:9038 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231502AbhIJIuK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 04:50:10 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A5B7xF016192;
        Fri, 10 Sep 2021 03:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0CG9u9+qxGIz4L6ADLzxji1KpOIMuVeRThHSMMnZauk=;
 b=LYVeJheEZgvDRHGNPYC0qIHTdL06Yy1+pxcdCO+8NVxa8VrxgafDAoBv2oxPPOFCFwSH
 zdnGKc8kOMM0SVTVcgpwGN+E8pghEKjbnl4NI5iwl4Tb4r4qCfhSYMhtnJfdFl6P14iw
 wCsKZ8dMsX7Ftbqx8dO56MSmpP4ciZ9EJFMuC1UbGtVilNWvxhOvxMdlVppDTv69Ou0I
 bgcBg4qFe5oZUvkbCfNLQXobENgO+sEsNSCLz4gT5CQJ3CW2X7Bd1aMzD4/FSBjDn7u4
 gB5oiX4yyYmj2eKZUvP5XQXP2EnJyzyAhKw9iPH9A3tzwRGN+nKs7s+cYsCgDrQaAuu5 lw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr0v04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 03:48:58 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 09:48:56 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 09:48:56 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0804E2A9;
        Fri, 10 Sep 2021 08:48:55 +0000 (UTC)
Date:   Fri, 10 Sep 2021 08:48:55 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/4] spi: amd: Refactor amd_spi_busy_wait
Message-ID: <20210910084855.GV9223@ediswmail.ad.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
 <20210909111005.304101-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210909111005.304101-2-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: oyWA1YisTXp2vAfePF8QQBDlkLPbBIkt
X-Proofpoint-ORIG-GUID: oyWA1YisTXp2vAfePF8QQBDlkLPbBIkt
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 09, 2021 at 12:10:03PM +0100, Lucas Tanure wrote:
> Use amd_spi_readreg32 to read 32 bits registers
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
