Return-Path: <linux-spi+bounces-9522-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD69B2BBB8
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D923AB085
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606731064B;
	Tue, 19 Aug 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHXOGQD/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA23451CF
	for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591790; cv=none; b=tlihRRkPn9nICJqV21Czp69cNexk6xHbeRtWB0uvXJ5aalHHt6ix2YXCWG14HAKnJM41Mfp80eqZBpjLwucqXY8OHLa3kgN6PDMf0pfGGV1N3k/2ZpiEF++Gfr+DGc8RJIAaY46O4Nxw7MxaYCNjkZxLNQmKdskLMvCXPKzLqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591790; c=relaxed/simple;
	bh=3GltQsZsTJB2ktXRLHZv7Us6GHmE2woUtqvFijXVQHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVrm46aGAwGzkprf2cOjmfeKvjFPKTiu6e5XZ1khrC85NYCU6wwD2rm54VizyUpOD4Sbpf/4IiLyrInSFYNWaI+cNC5bDL0G0CNAZIZU0B+3E0VlP4Mcfq1V0QJOqKXD9NKoj8WMbXEzb+t7zHRiNWlM/PSo1Qcd4dkVGre0l94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHXOGQD/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso36764465e9.1
        for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755591787; x=1756196587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk3UUuT0kF+OIQoIGwD56lsNrHwvbK9Pa+dkiVqzMsY=;
        b=MHXOGQD/XFQ+w6bG0xUTbtduZh22pYUKS9KR0dFe/zs2ax63ICbotJgsH0NS8MS61J
         n3Pd09UQxOH78z6oE2kIxESXMgujRJkTV6ui4zgb6jCsOrKsq5u65U6UIifC0QrnlzWM
         hj0fniwgb5gMm/f2ZaCaylvOy1rKJ8n1rl74SNOM82DJN+2YSs9Hiu2FhI0VshbvD6A+
         IeHj8oAvN2wwmuj5OOuienSTivM30EL32KdB+UTwYi4grOEqJH+NVq+l4e8kOOCnEnnN
         MZWqLlJAwruqa4zaJ/RX30etsbGM75y3GDsCGlQ14SxHB/FpZ6K5VJ1XtGJyyt4gb7sH
         rhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755591787; x=1756196587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk3UUuT0kF+OIQoIGwD56lsNrHwvbK9Pa+dkiVqzMsY=;
        b=BxRLCki3ChnxPy8pUSVQv1yY9JIoLfKHPS78RSqbJHKrlXkMquaLJxX5CRLrhNVBCW
         0pi2gBnjoOqYvI4ilSO9mfmBzT5/IRzkmPx55iDAndNbeTdF8J98/PBQyGNonsQUDcpC
         cJSJC+bL42ul49PdBU6ZC7jU4hU+gWufawZW+QcWfkTmaY0ioMpM11jo0N72sFZ9+Via
         Dru/GpwCzutcaWtkD0LAdcmRCjfIJiV1DTETlINkvnWedru9CS99r3ADIUoZjpuio3u2
         YXZkXYmOTCoNj9m/FRJLeJus1tVc6C1WeUBi2+gDo02SmSJXkd96Ag58NvyELHBbeQ2B
         qheg==
X-Forwarded-Encrypted: i=1; AJvYcCUdo3LoTQDIVeDbC4o5oZYrwOtNMqRS6JMy7+8eO4AnsbsYmyzSTFljiHU9ZxKe5Msr3czfEy6L0JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4uRMH2CTtPB3H0guVwSgr4PPKHhjO2fhau4hnYrMfJap8gKB
	cVoUPcUvstNPVP5OShplozM99C0guTsvZdbKFtuTa4uJ9vU7yOYgCaC/SlYnejWrjgo=
X-Gm-Gg: ASbGncsipmsrmld17KDhUjTPk8cDw9ZNjYHqnwHNpOTJRTLD04JycnQuNv0yulN47jW
	n6oerMFVsYAYVBGMY8RzrNCaVMkf+O0X41zk2sDM+zAPH0XGdvht8JnntjV1V3exSHrpKtJoJHq
	9u/r1GhkSoMzniMHmSs/kdbscmGXqD/f0Q+Je6h1O1n0zBO8nx3jE7T1kI23e+FISIbzAg0ei8l
	U+U7Vjd4QcyS1VClsIbuyhB/t4Tbrt7ga6K9hOu8SYxZNG3NFwnkgbdXDLs65Zi6E8FnG4lbAt6
	oeopnmmUbHBxmQKVvRhSN+nlUNBnOlaVJ/c0rRtg51ZSwpuM9+sbe1IAi4E7qD+tIRaKBC5ho4Z
	J+XYgB3GjJZtEOjz5BYbuydHo1SoMU7wGrL9m3A==
X-Google-Smtp-Source: AGHT+IFDBrqa6UO2Yq2aEToJiMTjs1+Jp6h8jHSwfsl8qYZjSrSubOzy3gKS/Bv9eTIZLkdGhNbxVA==
X-Received: by 2002:a05:600c:4446:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-45b43e0d613mr12404945e9.24.1755591787335;
        Tue, 19 Aug 2025 01:23:07 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a8debbsm30166165e9.17.2025.08.19.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:23:06 -0700 (PDT)
Message-ID: <5f3fa6be-3727-4536-b769-c0a3d1646c3d@linaro.org>
Date: Tue, 19 Aug 2025 09:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for S32G
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
 <aJ4qNVIp788gc2ZU@lizhi-Precision-Tower-5810>
 <1f3b68d4-e0cc-4952-a695-322ed9756b95@linaro.org>
 <35f6a3be-d924-403d-b60b-d4c78d833a60@sirena.org.uk>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <35f6a3be-d924-403d-b60b-d4c78d833a60@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2025 4:18 pm, Mark Brown wrote:
> On Mon, Aug 18, 2025 at 03:31:08PM +0100, James Clark wrote:
>> On 14/08/2025 7:25 pm, Frank Li wrote:
> 
>>> binding doc should first patch. Create new patch serial for add S32G
>>> support only.
> 
>> I'm not sure putting the binding doc commit first would be right? That would
>> imply it was a valid binding before it really was because the code change
>> hasn't been made yet. Practically both are required so it doesn't really
>> matter which way around they are.
> 
> It's the general practice everyone has adopted (though in this case the
> bugfix bits might want to go before the bindings, possibly it's also a
> bit unusual to do that).  An unused binding is more acceptable than an
> undocumented one.

Fair enough. I can flip them in the next version.


