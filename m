Return-Path: <linux-spi+bounces-2320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F48A1D93
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 20:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199EF283F6C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C091E6F7A;
	Thu, 11 Apr 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BpYB3Wg8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15F1E6F6F;
	Thu, 11 Apr 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855606; cv=none; b=kxYv8/Wm/KG6tjC9C0mDUVRV9pZAoz92PUrTd+jK25+Ok2DpN6wGEL90RyDmFX8DSaReG7458IaIdANHw7qGYAqsiTx+01WjHYYbKZDZamObH3PFowca+YJ7lsHFeeVFbxOAGZWnvI2KvJv1bpvHPuxPtYURjzAiN3jO52SVcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855606; c=relaxed/simple;
	bh=OAkb6O93bCbim6J2BNly7gzfaDzf9BuBjbDFoXODMM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgTBnKyJtHzqJ17iqO2d0rt7KTm/bw7omq6EJa251Mz2b90iOGVCv8oiwLU+PouVQT/cdvTPPUpS2wk140PUV7QH/uhR3nJxZtC+LLZysehp6pIeDJ2tHtvrlvcHSIaS4QsPtshnwlAgfV2zf12epPh03evi8JklvehyNMEoAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BpYB3Wg8; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B40ALn009489;
	Thu, 11 Apr 2024 12:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=MVsF3Y6/tW0tUDnyjWrIIKO1P2oaUgkqMmz08BtWtgU=; b=
	BpYB3Wg8/aap59AWs5VEZ3Nnf1qgARGhbPYvr5na8qEElv8LMUGlnCxe4CzcCLY7
	+GU9lda/2wd3mLKReA2cxSf5L2vFYIOWhISE6K87BBgTlEnSg9J/NfR3a/FRvyWe
	+e9Tl/BAMsLARlDCzxb63SiyZIgx4MNhLb3tUoffu6QC07a8ZnR5HGdebgowgIwF
	O1lBAh2qZZc7zTKO7jPEWDmnifF9XzoMkRFSgmXbXUARiXfVDsMJEnIlaSM4/814
	8lisXR+dtm5ND3fxLYVIx2FfiAgZTavgyVoanoC0KYVTxMeIsXYfRTAqo/NWv+os
	D1Q0A10fsoXDqZnSAfxIZA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxqcaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 12:13:18 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 18:13:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 18:13:16 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 74359820242;
	Thu, 11 Apr 2024 17:13:16 +0000 (UTC)
Date: Thu, 11 Apr 2024 17:13:15 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <bard.liao@intel.com>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v5 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhgaK9vhtvy3/YpU@ediswmail9.ad.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
 <20240411090628.2436389-5-ckeepax@opensource.cirrus.com>
 <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve00EuT0AdZy0b6OfqHySNkxTBuUbrv7z+mUgcrT56QWw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 1OExJAL_JgbNifayXx0Zj9S90ytHXE2u
X-Proofpoint-GUID: 1OExJAL_JgbNifayXx0Zj9S90ytHXE2u
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 11, 2024 at 05:04:33PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 11, 2024 at 12:06 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> >
> > On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> > to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> > by a SDCA class driver and these two amplifiers are controlled by
> > firmware running on the cs42l43. However, under Linux the decision
> > was made to interact with the cs42l43 directly, affording the user
> > greater control over the audio system. However, this has resulted
> > in an issue where these two bridged cs35l56 amplifiers are not
> > populated in ACPI and must be added manually.
> >
> > Check for the presence of the "01fa-cirrus-sidecar-instances" property
> > in the SDCA extension unit's ACPI properties to confirm the presence
> > of these two amplifiers and if they exist add them manually onto the
> > SPI bus.
> 
> ...
> 
> > +static const struct software_node ampl = {
> > +       .name                   = "cs35l56-left",
> > +};
> > +
> > +static const struct software_node ampr = {
> > +       .name                   = "cs35l56-right",
> > +};
> 
> Still I fail to see how these are used. They provide just a static
> swnode with name and no properties. How is that different from the
> no-fwnode case? Can you test without these being defined?
> 

The code in the last patch will pick up the name and use it to
name the amps that are registered. This means when those amps are
referred to by the audio machine driver code we will know what
they are called. Admittedly that audio machine driver change
isn't in this series as it is a bit of a work in progress and not
technically necessary for just registering the amps as this
series does.

> ...
> 
> > +static const struct software_node cs42l43_gpiochip_swnode = {
> > +       .name                   = "cs42l43-pinctrl",
> > +};
> 
> On the contrary I understand this one (however, using that generic
> name prevents more than one or two drivers from being instantiated).
> 

Yeah that might need to change in the future, however there is no
obvious use-cases for using multiple cs42l43's in a single system
so at the moment we are not doing the work to support that case.
There are plenty other things that would need fixed to support
that as well.

> ...
> 
> > +       SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
> 
> gpio/property.h for this one.

Sorry, still not quite following this one, are you just reminding
me to include the header when I move the swnode_gpio_undefined
definition or are you asking for something more?

> > +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> > +{
> > +       static const u32 func_smart_amp = 0x1;
> > +       struct fwnode_handle *child_fwnode, *ext_fwnode;
> > +       unsigned int val;
> > +       u32 function;
> > +       int ret;
> > +
> > +       fwnode_for_each_child_node(fwnode, child_fwnode) {
> > +               acpi_handle handle = ACPI_HANDLE_FWNODE(child_fwnode);
> 
> > +               if (!handle)
> > +                       continue;
> 
> This is _almost_ redundant check. handle == NULL is for the global
> root object which quite unlikely will have the _ADR method. The
> specification is clear about this: "The _ADR object is valid only
> within an Augmented Device Descriptor." That said, the check makes
> sense against the (very) ill-formed DSDT.
> 

I am willing to be guided here, but given it would result in a
null pointer dereference I am inclined to keep the check
personally.

> > +       if (has_sidecar) {
> > +               ret = software_node_register(&cs42l43_gpiochip_swnode);
> > +               if (ret) {
> > +                       return dev_err_probe(priv->dev, ret,
> > +                                            "Failed to register gpio swnode\n");
> > +               }
> > +
> > +               ret = device_create_managed_software_node(&priv->ctlr->dev,
> > +                                                         cs42l43_cs_props, NULL);
> > +               if (ret) {
> > +                       dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
> > +                       goto err;
> > +               }
> 
> Wouldn't it miss the parent fwnode? I mean that you might probably
> need to call...
> 
> > +       } else {
> > +               device_set_node(&priv->ctlr->dev, fwnode);
> 
> ...this one always. Have you checked it? How does sysfs look like
> before and after this change on the device in question?

I will check this.

Thanks,
Charles

