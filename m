Return-Path: <linux-spi+bounces-5103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B699005F
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA39F1C21B41
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C562D148827;
	Fri,  4 Oct 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtKygXsG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087DF1487DF
	for <linux-spi@vger.kernel.org>; Fri,  4 Oct 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035941; cv=none; b=j+VaXLJ9JsqdOy4tr3BMMl6NAFe8tYWogSzroPdgRXnjPz6QK6Ztnvi0spzIfKN+EH+Kv2TFNIMLos+YmEVs+CVH9mNpm3EO0ygULP+MRfe+/R4KGqCiV+SR2oNMLIa8hyPXBbApVIVEjH/hoMBfRbTqVHOCerwOaAJuS7B9oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035941; c=relaxed/simple;
	bh=49uezkyLI8iM7VDQsurtd7Q2j7ljfzOnPmv1HLElVb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lm7PFEPTBdaYNg5VBEY8DettoExticOBj/PIlIUKGWfcrH6qAvL7qy7mJSQA/fFyHi2BY0u184RkRtXwGzalQnyD/AdroBU0pnTppjUeLOxseG3Pa1EfFqnwWo659HLiCbwb03atr9VhF+yd/H1FgT/mBn4mF0VkkME4hgpMfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtKygXsG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso11820045e9.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Oct 2024 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728035938; x=1728640738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9D8jNEMTVQMfsSMYA6l2aONN4ZAr4dXC3Yqk6ph8dI=;
        b=LtKygXsGbwChpaUSE+TSl2fgnfK5rspuRSe+fpZL1SXRw1IgLqFIJ3ArT5vx5dIk0+
         Al63eDPiwBDP4lqrjKV7w2i9vXKCpFzntg/p0q7Lg1TRIW/nnwfqUevvxp19cuXdX09G
         ecNluz1zVnTBxqCKgpSpgO8+QfUHlMK1JiNTji7E/3bRm09XaqkcesmkDV5dhiy8L9A6
         RLGS+lfg5hFPhHlFsRIt24x2oaQgx7mDIfyA3dnQckBnAoKwdyYpE9fxA3q4LzZZ+/Bt
         RIwgR7awXapcSE/OhDAwfEJYNgydlH0xQlBQwFpddCRV2ezMk3XGmmC9/MGuGg2xBuJa
         0Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728035938; x=1728640738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9D8jNEMTVQMfsSMYA6l2aONN4ZAr4dXC3Yqk6ph8dI=;
        b=MSoQ5NoQ+6Z8WTLAkHKw5cIgKJe/3/r1H1C0XdftwFNY45fdwGtBxo59qNOkETbWEY
         9TQdMh/Sd5jV78njxK82w5ev53uvhJtxlaPTiOf2fcRcQGcPIH6dPiLO4opOUcFhBvWf
         VbA3hJCWnMM/GB/ZX2o7tRk6d6xeOqqAxydrofdcl+yOPh460zbXmgZVoB+jEx9XgEVr
         e25cuSURPcmrNs3OIJL/dAsTitJo8fSAWUeQTRnF1up0Q2yWuGKMUPefl2HhVdVjg8i9
         /9pq5Mzk2PXfjSJVCjvn9OoGxhJZfEuzqej2z8DYPQeZk3bJp6tkdyAcPhTWCTM0d4I4
         UWfw==
X-Forwarded-Encrypted: i=1; AJvYcCUVYFZeRNg4Nz6mSO9AcAvVRhdyyoX6VQtPH8HKhNi8ETbp/gSZFgNvWTZFO4/KCDh3F3sjRofZsBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmK+ZqhI0czm984EqLtDw8/306sGLRQiI9W4LhBxIAl1e7yf3C
	jjribsJx0nZTOibVuBwiwAomC2nX5EgzRd19Gb7EqDMLL2PN30J02Ejs9IVLB4aHwGMCg/ickwG
	B
X-Google-Smtp-Source: AGHT+IFdSdIQpV9WBffhi5FeGlu8JU/86cb4ysbANQ/IIXys7W2HAz4tWStag33lEg4hOJ5EK9M/Qg==
X-Received: by 2002:a05:600c:20c:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-42f7df1e5damr39358705e9.8.1728035938272;
        Fri, 04 Oct 2024 02:58:58 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d5fesm11573295e9.24.2024.10.04.02.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:58:57 -0700 (PDT)
Message-ID: <890c1926-2778-41e3-bca6-d08a5a493708@linaro.org>
Date: Fri, 4 Oct 2024 10:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/6] mtd: spi-nor: add Octal DTR support for Macronix
 flash
To: Alvin Zhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-2-alvinzhou.tw@gmail.com>
 <28ac1c39-5592-4e5c-8fce-53489e0135ee@linaro.org>
 <CAPhrvRQirexA9QJzBSqjfmPnbnF62-hzg-neQ-cZX2hnkP_Zwg@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPhrvRQirexA9QJzBSqjfmPnbnF62-hzg-neQ-cZX2hnkP_Zwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/4/24 10:05 AM, Alvin Zhou wrote:
>>> +     /* Read flash ID to make sure the switch was successful. */
>>> +     ret = spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
>> can we use nor->addr_nbytes for the second argument? Please test and
>> confirm. No need to resend for this, just confirm and I can amend when
>> applying.
> The following is the process of spi_nor_scan()
> int spi_nor_scan(...)
> {
> ......
> ret = spi_nor_init_params(nor);
> ......
> ret = spi_nor_setup(nor, hwcaps);
> ......
> }
> First, within the spi_nor_parse_sfdp() function inside
> spi_nor_init_params(): nor->params->addr_nbytes is set based on the
> SFDP, while nor->addr_nbytes is not available. Therefore, the second
> argument cannot use nor->addr_nbytes but can use
> nor->params->addr_nbytes. Additionally, For Macronix Octal NOR Flash


nor->addr_nbytes is set in spi_nor_setup().
spi_nor_set_octal_dtr() is called after spi_nor_setup(), thus you can
use nor->addr_nbytes.

> in Octal DDR mode, both the address and dummy cycles are fixed at 4
> in READID, so setting the second and third argument to 4 is also valid.

but we don't want magic numbers or states that are not tracked, so use
the parameters set

> Moreover, nor->addr_nbytes is set within the spi_nor_setup() function.

yep, use it then.

