Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03504068B4
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhIJIsr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 04:48:47 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44866 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231502AbhIJIsr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 04:48:47 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A5VHLT013636;
        Fri, 10 Sep 2021 03:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=rOhfXC7sHBEvR7/dWcSMGOF2uz7Di1A6fzXYCY1IRpo=;
 b=jnCPoZKdhAqBc7q1gEzbchc9mSG0Ir7Id+t0DTjGY1lCpub7v/Jr1N84rTO6eENEzAj/
 qMMNcXw1IvdiFn1khLgRYAWfQvV451daPlNUakDTPgHeF/7o3rn6ThWk5Jlsr6pvetQS
 GEP1r+HOLlIc3S0aLc1cs29z4HAaLTXQPb38eOHmYHuJ+OdcWHwnV9Z9bZhFnATTbHYr
 lOPRW9gdKSHq9jUapBMD6XUKp6LyKqLT0ZuqnuiDqxpOFb7o1ZwxiFgSYpgxyzjDujqe
 BsaZYr06GnWZDVuhj5pT86ilZQXUAHbZcKiS+mPpFYNOMaXg7ezR38K6H6sVgc+i0oSC GQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr0uy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 03:47:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 09:47:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 09:47:31 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8657A2A9;
        Fri, 10 Sep 2021 08:47:31 +0000 (UTC)
Date:   Fri, 10 Sep 2021 08:47:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/4] spi: amd: Refactor code to use less
 spi_master_get_devdata
Message-ID: <20210910084731.GU9223@ediswmail.ad.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: TTbCO2G_qxBwivlHGuUEcr5bZppdApW0
X-Proofpoint-ORIG-GUID: TTbCO2G_qxBwivlHGuUEcr5bZppdApW0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 09, 2021 at 12:10:02PM +0100, Lucas Tanure wrote:
> Get master data in the start and then just use struct amd_spi
> as it has the needed variable
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
