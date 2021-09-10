Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BED4068B9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhIJIuy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 04:50:54 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52748 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhIJIux (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 04:50:53 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A4vuV0005222;
        Fri, 10 Sep 2021 03:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+VVlZj3Buq5MZo0EYCefttH8P2g8kmajHGA5esW942Q=;
 b=IsuJLGNLjYu5kIBYQAJXmQfIudyC0gaBP+Fmwt66VRKoy+jsPhwpaDLDtmuIGHSMrX10
 yY5IReko5UHACsIIBSfhQtzyPL4WIEfwf4REg7g0IBjcgaqCZC/njrqB1yeiCBo/IBq+
 M+0cziEdNQm8WKQ6bp4i75RngCCvcMzTvM6K9bgDnVxCM1791v/xw3xNkBdNje4PaJE5
 5wwcDvpQgWo3YPRGe8bnOyQ2L6j4fy9Xu9oGA8EoEkS0hamHhBjAlZutPh8rG1WwnlLe
 C0PLBbFN2OccpLSC/FgrAlsf9DMEupZ7XulZWVyzmLuh+Ina9C/uqt6TtJVR2+HrCygm MQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3aytg78s5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 03:49:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 09:49:38 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 09:49:38 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D3E13B10;
        Fri, 10 Sep 2021 08:49:38 +0000 (UTC)
Date:   Fri, 10 Sep 2021 08:49:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 3/4] spi: amd: Remove unneeded variable
Message-ID: <20210910084938.GW9223@ediswmail.ad.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
 <20210909111005.304101-3-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210909111005.304101-3-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: WkD8SVxy-HM6ylY1QV00SD7GIfXQXj5z
X-Proofpoint-ORIG-GUID: WkD8SVxy-HM6ylY1QV00SD7GIfXQXj5z
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 09, 2021 at 12:10:04PM +0100, Lucas Tanure wrote:
> Remove internal cs from amd_spi
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
