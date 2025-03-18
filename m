Return-Path: <linux-spi+bounces-7185-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE84A66BBE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA27C7A7B5C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE31E520F;
	Tue, 18 Mar 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVKN73q4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9F1DE3A5
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283219; cv=none; b=iASAUfDXVxi29QyzayePk1tBO1uVVrFjpn2OEVYG0mS45Y5ObHK30My4SHR/BqyIqRMWG3evku96op9X7BqHflXqmZyAzz7bgeeWskXt+rTb2Qvl2tyR5MAkAPxGtUoLJPbAhRodUr4s+6qZnUTFoV1N8V/AJrJnHO4RZfJf1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283219; c=relaxed/simple;
	bh=8wzE6JQOqeICaxML7C018pHl5X7ishDt9mrfTLXYJyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soGN+YZkevlHfE4nZF5F7gaIqe1+QTKg8DoTtTxjS6FE+GGANeer90gdRkXwo0pgOHyfMvfPySjx/H7A1dRNT3YD3RFPWEkE1zMoGxnDAzpK8jv3+qlYmRSPcJku37YXaHpOAJZ1fC/MzQgWw3umM5vDyU/2wC+MfRPoZyrRLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVKN73q4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so132143625ad.1
        for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283217; x=1742888017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOISki8dnLdBinmyN5Fhhwr/b+hOKzHW4IWqOj6LscA=;
        b=nVKN73q4CCjo2AgKYwkfE9EqfswVwo92wiI39Dr2osL8XntAGgJLYllldQ90JiiAmc
         bEjbmZWi1K5mfXoGOep3PVz1sa2fYlVJKbZqEfAiUw5I2az2jdV4iXyUNbD273f2a1D8
         uJPJabu3MP/sS9dazEYVf/HJs9q8HF8/nB/AA7MABg55eOBefLdfI7abuMQHs6aw1bHo
         WUgaQVt4I4UCeY0jbk1qK7MzQyGPeeJwr8NISWBcPF6cmR2MEtBUTuT9fnT8dJl6N9FW
         dec6YwQPsfEeJZuFhDMSB0t0ailAYEs7ANHXYXBcy7s8ZLr0gViI/met6cHkp1ryZWqD
         t41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283217; x=1742888017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOISki8dnLdBinmyN5Fhhwr/b+hOKzHW4IWqOj6LscA=;
        b=Pn6Csm2u0TyJ7SgMg3jD9Qb2oVcyvrtHiKFVorj+rEz9dSjbhPkvuNjq/h+DrxB2XV
         HvR/UKlCZMTcoPQ2J+MBfugqJ9lEBxXyG/3eEtyGDPAES8N6pGKiSFLxxQ0TpWyf/q88
         2oSWgC9xTW5IR9HJQuMT/QHr/hlIGYn837epA2+irY9pcDtytKD3zq2yiNPQbdkck4ce
         AOz7W8AT5F2iuHXCu8lqAYAxhyf7c7VEacQmakl51w7h/iZTiML0wUNtoUq7JKlV9tWV
         g+wRlOFqvG4rqdmS887am0YoldNPMOQwGh4L7dFR2Gn8pqqZ7Lb5XMy48kFNoc9PCrdw
         HAww==
X-Forwarded-Encrypted: i=1; AJvYcCVnlv9GcVZtyc9sdtiLjZf/3WHDPDk8GJXHdEIRn/WEO8r+w+QHdfcTIOag3eQcWCd+woGw1vnIqsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscHlICPlmP9WSARTJKGdCieAnPGb2DYL/bAlF0wqXv2rhDjBJ
	ETUFgkfLkmobKVcMxRrX0cZX8C6vrJZviKdi/Kw+nCRNWlD172Ayme4YQFuiCg==
X-Gm-Gg: ASbGncsMysXk0DwyTyaFC+z5YJRtHAzTscld78rACwan0exJ+mtgyFwEv5xva+38Wj3
	uI6u80kvRa8YXu98aO/tTf4D8Fb5iwdxSoBV115lWYMFMrcOMCERmdYNCOjKpiU5Yt4s8MMZMze
	SECHJ6MwWOHxivif2ZYgzWhBKsL5koTf9jU1D24TQTLlnEkOPE33wfb3fKRQazGG7tuPFyFynPd
	GJd0T9oWrrH4mteJ1jQxdjbVZrzz2clpB6VMiFeDTphPUxtPcMszNbwMQoityPXqpZEvRii1E47
	UELPLMDqTBwl0ANrftLK1h5SXsc2M9Rix/QIZL8vRXdpO74667upnU8+E2ELldgIINg=
X-Google-Smtp-Source: AGHT+IHFVJZtu55P6A5DXRQBgEp/mTXhH/XT9ESOfze6ksB+o7qEeCG3zUQ7NMUJih+FIIspGKyTcQ==
X-Received: by 2002:a05:6a00:3cc8:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-7372239a441mr22267474b3a.8.1742283216714;
        Tue, 18 Mar 2025 00:33:36 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73760713875sm260507b3a.33.2025.03.18.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:33:36 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:03:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC
 base address to BAM
Message-ID: <20250318073332.guylcyqjmfq5nyyr@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-2-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:03PM +0530, Md Sadre Alam wrote:
> Currently we are configuring lower 24 bits of address in descriptor
> whereas QPIC design expects 18 bit register offset from QPIC base
> address to be configured in cmd descriptors. This is leading to a
> different address actually being used in HW, leading to wrong value
> read.
> 
> the actual issue is that the NANDc base address is different from the
> QPIC base address. But the driver doesn't take it into account and just
> used the QPIC base as the NANDc base. This used to work as the NANDc IP
> only considers the lower 18 bits of the address passed by the driver to
> derive the register offset. Since the base address of QPIC used to contain
> all 0 for lower 18 bits (like 0x07980000), the driver ended up passing the

What is this address? Is it coming from DT?

> actual register offset in it and NANDc worked properly. But on newer SoCs
> like SDX75, the QPIC base address doesn't contain all 0 for lower 18 bits
> (like 0x01C98000). So NANDc sees wrong offset as per the current logic
> 
> The address should be passed to BAM 0x30000 + offset. In older targets

You gave no explanation on how this 0x30000 offset came into picture. I gave the
reasoning in v2:

"SDX55's NANDc base is 0x01b30000 and it has bits 17 and 18 set corresponding to
0x30000. So it is correct that the IP only considers lower 18 bits and it used
to work as the driver ended up passing 0x3000 + register offset."

Then you replied:

"This address 0x30000 is the address from QPIC_BASE to QPIC_EBI2NAND
e.g for SDX55 and SDX65 the QPIC_BASE is 0x01B00000. So here lower 18-bits
are zero only."

No one outside Qcom knows what QPIC_BASE and QPIC_EBI2NAND are. We just know the
NANDc address mentioned in DT, which corresponds to 0x01b30000 for SDX55.

Please reword the commit message to present the full picture and not half baked
info. This is v3, I see no improvement in the commit message, sorry.

> the lower 18-bits are zero so that correct address being paased. But
> in newer targets the lower 18-bits are non-zero in QPIC base so that
> 0x300000 + offset giving the wrong value.
> 
> SDX75 : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
> SDX55 : QPIC_QPIC | 0x1B00000 (Lower 18 bits are zero) Same for

There is no address as '0x1B00000' in DT.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

