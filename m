Return-Path: <linux-spi+bounces-2212-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E05789C24F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 15:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F9B2BC55
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4398524AF;
	Mon,  8 Apr 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UhGchK5H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7087CF1A;
	Mon,  8 Apr 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582501; cv=none; b=i5lL3qOJuEBg/n3jQ3VD+Sex2OHguUKIFVnwR/Noc3O4zsTG58WdaVBHvimLMgkdv+sJTZoUFoIclbILBpJg2uKUF2hXrqW8q+QGvg9iZ8zROgH4Is8K7lsE4viCKgtM/Q9JtOZBiu1vHtNmcYWGJoY7q5U2lkrzT66BL9B3qgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582501; c=relaxed/simple;
	bh=CjpQJ8b4aFU0oVh0NvrFnDn+6wxRLAMcXQbbztGERgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1SLrjp5rlASxwlMqoPAlGyPuGDu3i3Uiw4DyN9jZ32QdIIfkhPa8/aOSTXlnAr9E7Hs0UecbMkd+xQFQK09J0yiA+jPcejXgac2Fg9aIIqiUYFGfvhSJBD1un5TqEJ+3RkR2Bp6K2Z7dgQlEDAZ4Uu3ExwX1G5RdAAfGcaCKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UhGchK5H; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlGN032409;
	Mon, 8 Apr 2024 08:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=Qfd5ZEN/T7ufn1fZ9013Xf77fPXo1Wh3Ymch+PVCmWU=; b=
	UhGchK5H2RdyhX33o/nvO+PxaiO5h8EmFRl72t+h2Px1OryVeaPyCgOlRHLwQsKr
	/C+CSlg5GfeJaDObciJmfv3ZJGe8axnwz5/tfj760H2Ih+CdMCR/WWZ0eLR6AGtU
	TONoTy7SsKP5SkO/SfozD3e/eX+V3yiWwhc3s1JmTFF3BKfZHo3AlrCTack7/07r
	93ZPTWNd4Ln2aqGnu4lnosO13TD8FYYMyYCPbAsOcCrL15PmDOV8sCSNrIj1ViMW
	588lulgWOzNiFN6tp1WJ3rO3/UvJL+qopob0yZ/W2FcRPxt/mtMFjd1mtN2XNPkJ
	omOLcm/cJFr0fRlygUl1Dw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhfum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 08:21:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 14:21:33 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 14:21:33 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id DE554820243;
	Mon,  8 Apr 2024 13:21:32 +0000 (UTC)
Date: Mon, 8 Apr 2024 13:21:31 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: <broonie@kernel.org>, <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <ZhPvW46kGeOnG++E@ediswmail9.ad.cirrus.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
 <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
 <CACRpkdZP_9y-Z=eZcbQe=ZF2ejutP6gD2ofTxXNvGTh7CUfwFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZP_9y-Z=eZcbQe=ZF2ejutP6gD2ofTxXNvGTh7CUfwFg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: VjLAU6ilhXmXIYpGhs6LqVtTqz40TE3x
X-Proofpoint-GUID: VjLAU6ilhXmXIYpGhs6LqVtTqz40TE3x
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 04, 2024 at 10:16:35AM +0200, Linus Walleij wrote:
> On Tue, Mar 26, 2024 at 3:11 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > +const struct software_node swnode_gpio_undefined = {
> > +       .name = "gpio-internal-undefined",
> > +};
> > +EXPORT_SYMBOL_GPL(swnode_gpio_undefined);
> 
> This needs a comment in the code telling exactly why this is here.
> It is also taking up space and code here on systems that have no use
> for it, so I wonder if it is possible to make this optional.
> 

Happy to add the comment, less sure about how to make it
optional. I could ifdef it based the SPI config, but whilst that
is the current user the mechanism feels like it is more generic
than that and could be used in other bindings as well.

> > +       if (!strcmp(gdev_node->name, "gpio-internal-undefined"))
> > +               return ERR_PTR(-ENOENT);
> 
> This needs a comment stating why this check is here, it's not
> obvious.

Happy to add a comment here as well.

Thanks,
Charles

