Return-Path: <linux-spi+bounces-2360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8858A6784
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 11:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0201F21DAB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540686250;
	Tue, 16 Apr 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GK561E+J"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA142907;
	Tue, 16 Apr 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261281; cv=none; b=oMGjnQymKs4mL6iBWih/w2aF9VVW8wEJ59bn4adNdxsIYJBFuQjSRy8tsD4nUDKMX/mkJ4U5ZXj9Ari6tyhuvJfrU+SXSumydPlrXOytH4kPcjaY7ghiAYGNGLzAjuXKTFGpdB6raylvHPAKGltlcaZPij3D0B5s5jWx7cRZ9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261281; c=relaxed/simple;
	bh=+n5rx+ZpI/hAMj2VQxAa5/lA17bxUuweIOB7zNGEiEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl5/EMN6gKKP57xiNhYDhOpiDcPvewBTnsBpS/w0IaYhki6liO4YOopOqAJ60l7mVK7zMMpsz6xj40n30jgSjZmWaSp5vOOW9u18C/4G9QXSmOypyy5aZpA12O8mPhRYQ5hZhcIZXtWe2EgILUaaOwMNN9XwSYHc191rCwzWNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GK561E+J; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G5uYOx005067;
	Tue, 16 Apr 2024 04:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=AfqbDy3smU6Phro92zN5i+y8gIJE5BMGKkvuP8tN6xs=; b=
	GK561E+JS4amLEyIco5pMNT1wKqtPjGqvLwxzFLqld/EsdjkINeZekuEAx0LKc9I
	pmpBfee9aeszINy0S7uQtOGuCRlHDxRLz2GxxhZl57JCHtrMC8BXAJbNQkJDlOl1
	V9kVxA32fIvdvXFBdQjbaIMaHtFdmOb/OHgDr8iznnf1Puo6+VZcwgo2rf8rep6v
	rf9bwE3xGv9fAE84qOZoowZvHkay56N7Ezax6zD/0qg1z/DGKjLSErXA7BEOBYxI
	JJ9FHCR80A6jaQmmRA9xoCGK8NNmHPt4MIof9IwzzO4JX/jyS58ZL+P49j4VWrGK
	g8A6mC7kIQcx7Dg4K00jBw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhtd43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 04:54:33 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 10:54:31 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 16 Apr 2024 10:54:31 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 64691820244;
	Tue, 16 Apr 2024 09:54:31 +0000 (UTC)
Date: Tue, 16 Apr 2024 09:54:30 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v6 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <Zh5K1mR+VwsQgqud@ediswmail9.ad.cirrus.com>
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com>
 <20240415140925.3518990-5-ckeepax@opensource.cirrus.com>
 <CAHp75Vf-n=crCpRnKQ-030czDJFJmp6J+QStiehYwdMwGM+zog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf-n=crCpRnKQ-030czDJFJmp6J+QStiehYwdMwGM+zog@mail.gmail.com>
X-Proofpoint-ORIG-GUID: jvdAMJh3sBL_i5lwMhPF0aHeUtOunelD
X-Proofpoint-GUID: jvdAMJh3sBL_i5lwMhPF0aHeUtOunelD
X-Proofpoint-Spam-Reason: safe

On Mon, Apr 15, 2024 at 07:17:16PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2024 at 5:09 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > +static int cs42l43_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
> > +       struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
> > +       bool has_sidecar = cs42l43_has_sidecar(fwnode);
> > +
> > +       if (has_sidecar)
> > +               software_node_unregister(&cs42l43_gpiochip_swnode);
> > +
> > +       return 0;
> 
> As this one.
> 
> > +};
> 
> You will remove the software node before removing the controller, this
> seems incorrect ordering to me. What you need is to wrap by
> devm_add_action_or_reset() and it won't be any remove() callback
> needed.
> 

Yeah this is a good idea I will update.

Thanks,
Charles

