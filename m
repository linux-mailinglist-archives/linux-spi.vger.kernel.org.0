Return-Path: <linux-spi+bounces-2223-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42B89C86F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BD6286DBE
	for <lists+linux-spi@lfdr.de>; Mon,  8 Apr 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F249140E5F;
	Mon,  8 Apr 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mB2Cdges"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF181E4AF;
	Mon,  8 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590556; cv=none; b=WQ5XxZd7mCUrpSjNdV/zsU0YJSICB4ShcgvRpQ+RLFm28JJgFbtucWEUlCof/qxDs1/X+UiiUd4LMVitnVoR6JVYWSdisvULGkkAIgy0cunfA+oWoHf6hdBefKXQ0NkarV1D6GYRCgNSYsyI7wsvD56ap3ZRSAXwtp2E28YQ8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590556; c=relaxed/simple;
	bh=nfhXUuDM+wQiCwJoJQ/JfBm25BuzySMiazVENfH/Afo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNFtW1GuX/tCxr13e0xSRS7wx8ZZ+EWE88kdRuUFXwpW+v1Zv8W36p7XcXQJ/gW9zkj9OjCEkQTw3q7PYc1IaZ92QpEkimZrSHjxBw2rNGNnnzRaUh4cRDOB9eby+uZAoo9T/12ZaP9zKyViLIAJcADgOBNQiVmRBgf0UmuXhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mB2Cdges; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43850rko005178;
	Mon, 8 Apr 2024 10:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=5ZqHoK67TZfwoNt
	kp7APkFwF8BKF7L62HyD7fMD140Q=; b=mB2Cdges9z4sLBZE7oOYF2U1KYUTQ3K
	k0at5brq/pU0MafzkcvKWBs8RXYQbtteGwS4Frtufbg0bdQqW+QGkSAFjwTzZ3Lh
	0ZohfgF1PHiTMqxcUGYMRiPsNqZsk6Hdm6dSH8wkNHdHJpG7/3E2JG5ui4A4I7Eb
	dawMIx3NdjneMLUH23CL103rmomb6M+NeHkf0SJ4LixW4lv8u90cAIgpuptYhhNl
	EQLBAGZ2LanxNBc1a6ZTkrew0VEIfNmozGv6m8pbAeYYCRVEzrytspr0F/9bSequ
	qNNUWOaj5cNT26uK4FupF7vDnIxoReFxfpmX7RKFFbBLV7MLz6xELJg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhmbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:35:49 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 16:35:47 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 16:35:47 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 57F72820242;
	Mon,  8 Apr 2024 15:35:47 +0000 (UTC)
Date: Mon, 8 Apr 2024 15:35:46 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <ZhQO0vTvr67bR2O9@ediswmail9.ad.cirrus.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-4-ckeepax@opensource.cirrus.com>
 <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zg3AaNM0eizfC6Bk@surfacebook.localdomain>
X-Proofpoint-ORIG-GUID: 7zXdBPhC_44Yvty_oRGT4tIjoWOFl76p
X-Proofpoint-GUID: 7zXdBPhC_44Yvty_oRGT4tIjoWOFl76p
X-Proofpoint-Spam-Reason: safe

On Wed, Apr 03, 2024 at 11:47:36PM +0300, Andy Shevchenko wrote:
> Fri, Mar 29, 2024 at 11:47:30AM +0000, Charles Keepax kirjoitti:
> > From: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > +#include <dt-bindings/gpio/gpio.h>
> 
> Hmm... Is it requirement by gpiolib-swnode? (I haven't looked at the use cases,
> I'm not the author of this idea, hence the Q).

It's required for the GPIO_ACTIVE_LOW used in the swnode stuff.

> > +#include <linux/acpi.h>
> 
> You need array_size.h (and perhaps overflow.h) and property.h.

Good spot will add those.

> > +static struct spi_board_info ampl_info = {
> > +	.modalias		= "cs35l56",
> > +	.max_speed_hz		= 2000000,
> 
> Maybe HZ_PER_MHZ from units.h?

Can do.

> > +static const struct software_node_ref_args cs42l43_cs_refs[] = {
> Please, use SOFTWARE_NODE_REFERENCE().

> > +static const struct property_entry cs42l43_cs_props[] = {
> You want PROPERTY_ENTRY_REF_ARRAY().. 

Can do.

> > +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> > +{
> > +	static const int func_smart_amp = 0x1;
> > +	struct fwnode_handle *child_fwnode, *ext_fwnode;
> > +	unsigned long long function;
> > +	unsigned int val;
> > +	int ret;
> 
> > +	if (!is_acpi_node(fwnode))
> > +		return false;
> 
> Dup, your loop will perform the same effectivelly.

Are you sure? Won't adev end up being NULL and the adev->handle
will dereference it?

> > +	fwnode_for_each_child_node(fwnode, child_fwnode) {
> 
> > +		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
> > +
> > +		ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &function);
> > +		if (ACPI_FAILURE(ret) || function != func_smart_amp) {
> > +			fwnode_handle_put(fwnode);
> > +			continue;
> > +		}
> 
> acpi_get_local_address() (it has a stub for CONFIG_ACPI=n).

Thanks was looking for something like that not sure how I missed
that.

> > +		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
> > +				"mipi-sdca-function-expansion-subproperties");
> > +		if (!ext_fwnode) {
> 
> > +			fwnode_handle_put(fwnode);
> 
> Are you sure?

oops, yeah those should all be child_fwnode.

> > +	if (has_sidecar) {
> > +		ret = software_node_register(&cs42l43_gpiochip_swnode);
> > +		if (ret) {
> > +			dev_err(priv->dev, "Failed to register gpio swnode: %d\n", ret);
> > +			return ret;
> > +		}
> 
> > +		ret = device_create_managed_software_node(&priv->ctlr->dev, cs42l43_cs_props, NULL);
> 
> No, this must not be used (I'm talking about _managed variant), this is a hack
> for backward compatibility.

Hm... odd, feels like the function could use a comment or something
to say don't use me. But we can go back to managing it manually
no problems.

> > +		if (ret) {
> > +			dev_err(priv->dev, "Failed to add swnode: %d\n", ret);
> > +			goto err;
> > +		}
> 
> > +
> 
> Redundant blank line.

yup.

> > +	} else {
> > +		device_set_node(&priv->ctlr->dev, fwnode);
> > +	}
> >  
> >  	ret = devm_spi_register_controller(priv->dev, priv->ctlr);
> >  	if (ret) {
> >  		dev_err(priv->dev, "Failed to register SPI controller: %d\n", ret);
> > +		goto err;
> > +	}
> > +
> > +	if (has_sidecar) {
> > +		if (!spi_new_device(priv->ctlr, &ampl_info)) {
> > +			ret = -ENODEV;
> > +			dev_err(priv->dev, "Failed to create left amp slave\n");
> > +			goto err;
> > +		}
> > +
> > +		if (!spi_new_device(priv->ctlr, &ampr_info)) {
> > +			ret = -ENODEV;
> > +			dev_err(priv->dev, "Failed to create right amp slave\n");
> > +			goto err;
> > +		}
> >  	}
> >  
> > +	return 0;
> > +
> > +err:
> > +	if (has_sidecar)
> > +		software_node_unregister(&cs42l43_gpiochip_swnode);
> > +
> >  	return ret;
> >  }
> 
> Wondering why don't you use return dev_err_probe() / ret = dev_err_probe() /
> dev_err_probe(ret)?

Yeah some of those should be, will update.

> > +static int cs42l43_spi_remove(struct platform_device *pdev)
> > +{
> > +	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
> 
> platform_get_drvdata()
> 
> > +	struct fwnode_handle *fwnode = dev_fwnode(cs42l43->dev);
> 
> Is this dev the same as &pdev->dev?

No, this is MFD parent device, to be fair could probably use
parent directly here. Will have a think about that.

Thanks,
Charles

