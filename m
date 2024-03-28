Return-Path: <linux-spi+bounces-2081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA93890336
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 16:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8121F242C0
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707BA12FB2E;
	Thu, 28 Mar 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUAIhv8w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AB12E1C8
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640278; cv=none; b=iP4Sa4+stcBMTcJZ28khu2pe988qjNRjivdtBym+1GgRVesMU/3C8unNEuOJIeIfwL8DsHQkvPHbD7RN02jPY43qORbV0y936Q7YtiYAoZ2q9xYcU9Di+DsuRubPX3Bouj5QxMhYT6tZmAA9JAGqZLi+l2mh7gUBQq5WNIJ5DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640278; c=relaxed/simple;
	bh=wrtkQUXt72sLMQI+K0oHfWPeA0OqB1bI7JA2SlyFaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeR5nro8HKJAV52Q6wcnmYgUGpSL6qdDerF/0mKGUKPKcCG5l98irxmauvXQ1+s++1F5WfZyHvx8j/vSvu+Bf2lJ709LQNLRyJ6BNf9jUjnEBBUyQExfy7gjWhzWvNE7R0kJ8LC+WPP8Ly8MNbjfGbK8vFWYrbeFwG+bll2IZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUAIhv8w; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a465ddc2c09so65925466b.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711640275; x=1712245075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANzWgKm0bntWute8nMO1hl60enZ7+Hd5zAXwL8KZonU=;
        b=EUAIhv8wi6vqaNsIpJKsRVX0YCCAprRuY807v96tt0MKRjxxP36FNyaUBnBdIHIuZB
         ng3yCil6scZmaQ6NWqkwJLnpcAYGma/JqJUPCoATRh/nV/vQZQr0E6ppW05/Bg9TfBap
         yb+LdcfZzdivgeZIacOhZ7+hLExha7Glr0uQzmj5kRpZUpTMkiNOsY8z4o2JB/YB6H8T
         f2/Fxvp5AwgVaFFUusGpcTqBOoeKIc8mmzSMrEu7DE0X/6HgDgrZ/ioPtkFWfrruUhS0
         aRHzPVqGiNXcSbYzyqv394lU/PM8qItkyHBrshGr7mLkWHKTdsheFww+iQoRCIrAiExn
         QujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640275; x=1712245075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANzWgKm0bntWute8nMO1hl60enZ7+Hd5zAXwL8KZonU=;
        b=U38EyK08NXHzMiuQLapSmQb+/IzZR2Tt8W4yQL4oOd1sxMn3u4N1Ks7TSyABh9GJNL
         V4nMrdyYfCvIl9QIxTnJikg7Lj4yDfKNwV5ORPLyZDBZ2k51655bOAgYpfTQnFaa68tR
         QvzlEgGdTCZFidjq8gbFJJCl18QvI9hqThK5v9jsjtppoWcoVkYK2G2GXkiVtjqVlT02
         +89cJghR+NXxytwhuTiYBKG7VouomnW8vdG0YaGZ6xz0xB92t631o4PA5IQAMe0bQYFC
         cJqtDEMSBR5uwBGCIS8womYkFGPGrAw7pk/OxUPZd2hl/0h6JfQL/Rcmav/ANZiJpkJx
         8dRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhN25E6HWpwB0KtSHMVRvaCYE4MJa2wJhVNAbRL+sfFzCFSVhYNvv0A+6OPBB+sDV7CQSK82wH0/4cSHBKUh5U3RY/PskPqBQU
X-Gm-Message-State: AOJu0YwwQvD+7Yjs9UwdI9yQz/jhMGq/bJPYzCCh1gyrPsGW910SdSRu
	frsnYMLu1C3CcP4pcBhXEWZTf4sh5gVVGpya7MWYml0hr7Lrm9tC/Ts0GTPbzC2l21iTMcFLo6p
	8
X-Google-Smtp-Source: AGHT+IEd1tJMNzmMnWP8OVhZsGW9fLDR48HTGQ59gEJ78HKyA7dTvTQO+FhPNz5oIiDw6YXW4+Dtkw==
X-Received: by 2002:a50:9e64:0:b0:56b:8dcd:acb5 with SMTP id z91-20020a509e64000000b0056b8dcdacb5mr3410611ede.39.1711640274848;
        Thu, 28 Mar 2024 08:37:54 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b00568d7b0a21csm947633eda.61.2024.03.28.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:37:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:37:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/3] spi: cs42l43: Add bridged cs35l56 amplifiers
Message-ID: <1123a418-c3c4-4f2b-b957-3737f3837b41@moroto.mountain>
References: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
 <20240328140119.1784350-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140119.1784350-4-ckeepax@opensource.cirrus.com>

On Thu, Mar 28, 2024 at 02:01:19PM +0000, Charles Keepax wrote:
> +static bool cs42l43_has_sidecar(struct fwnode_handle *fwnode)
> +{
> +	static const int func_smart_amp = 0x1;
> +	struct fwnode_handle *child_fwnode, *ext_fwnode;
> +	unsigned long long function;
> +	unsigned int val;
> +	int ret;
> +
> +	if (!is_acpi_node(fwnode))
> +		return false;
> +
> +	fwnode_for_each_child_node(fwnode, child_fwnode) {
> +		struct acpi_device *adev = to_acpi_device_node(child_fwnode);
> +
> +		ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &function);
> +		if (ACPI_FAILURE(ret))
> +			continue;
> +
> +		if (function != func_smart_amp)
> +			continue;
> +
> +		ext_fwnode = fwnode_get_named_child_node(child_fwnode,
> +				"mipi-sdca-function-expansion-subproperties");
> +		if (!ext_fwnode)
> +			continue;
> +
> +		ret = fwnode_property_read_u32(ext_fwnode,
> +					       "01fa-cirrus-sidecar-instances",
> +					       &val);
> +		if (ret)
> +			continue;
> +
> +		return !!val;

This should call fwnode_handle_put(child_fwnode) before returning.  An
alternative fix would be to use the new device_for_each_child_node_scoped()
macro.

regards,
dan carpenter

> +	}
> +
> +	return false;
> +}


