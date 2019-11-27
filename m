Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177F410B060
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0Nhb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:37:31 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:41546 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfK0Nhb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:37:31 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARDbQAm001704;
        Wed, 27 Nov 2019 07:37:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=cQl2L3+ANIksdQfNDmVP/REWufb381l6RcUnTlIUXGk=;
 b=VI0nbScGvyaULukK+AWlfWCqQV/BE4b8dsDLxNjW80bwNBDZ+BGwuLSlJXkubsEM4Lq+
 sA6AlbQPcFPriqUn27X0uK/MaTbZYHWE22PxVys+YJiarG8UKkVYV+pf/nUuyjt3Ux7z
 8uhi8QGJgh7sGk2BBTorGzKX1v+dvHTVckuM452onwpi7t3RM8cuEch6eNp8n7kO4kpu
 iRLM4nSmz05BlQuBCe9hyJkG+q1+JLC3pLq8/6qgoFQW1QceQp01booCeKjQu2VjeB52
 4HG4pouOvK5srthYq13MnCuInioJTeeaEZCv8tsWYeBJ0UVEJTHqrKY0qUFHDrqZBpSO uQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2whda3s1ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Nov 2019 07:37:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 27 Nov
 2019 13:38:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 27 Nov 2019 13:38:18 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D6552A1;
        Wed, 27 Nov 2019 13:37:24 +0000 (UTC)
Date:   Wed, 27 Nov 2019 13:37:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
Message-ID: <20191127133724.GB10451@ediswmail.ad.cirrus.com>
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
 <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
 <20191127115419.GA10451@ediswmail.ad.cirrus.com>
 <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdah5V7jDMUkDtdOb3RbR6mTsj5zs6g=Sb6KBZFRfme0rQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270119
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 12:59:34PM +0100, Linus Walleij wrote:
> On Wed, Nov 27, 2019 at 12:54 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 27, 2019 at 11:42:47AM +0100, Linus Walleij wrote:
> > > On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > But we are lucky: there aren't many of them.
> > > In addition to spi-cadence.c this seems to affect only spi-dw.c
> > > and I suppose that is what Gregory was using? Or
> > > something else?
> > >
> > I will go do some digging and see what I can find.

Yeah so looks to me like spi-dw is the only other part affected,
and it probably wants a similar revert done to fix it. It is a
little more complex as it has this additional cs_control
callback, but there don't appear to be any in tree users for that
(which I can find). So I am guessing any out of tree users
probably broke when the logic was first changed so the revert
probably helps them too, unless they have already changed there
callbacks in which case it will break them again.

Anyways I will send the revert and hopefully some people who use
the driver can test it for us.

Thanks,
Charles
