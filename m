Return-Path: <linux-spi+bounces-4668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984396DA26
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99991F228C0
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6F19AA73;
	Thu,  5 Sep 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMulNgST"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935219D078
	for <linux-spi@vger.kernel.org>; Thu,  5 Sep 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542585; cv=none; b=GFFHwr0yGjozDARM7xZ4sylAPCBDRnPKOYHSN7BXvXbsyGKZkZ8bnxIC2oJUVNwk+/Q4aPAHkJBApNQbtpc5itucrEe1FpBedC4DIF8mwuahAKdj86V5SJfseRVNguvVd5XlmFmaQ1UO+eOYI79tO1f2sZsts3h8QZpPxSc7tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542585; c=relaxed/simple;
	bh=kidWxzS9Q95Q5dbm7Dd7JdsGGV+Dkyu2kbgsrCl8iIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNU5cdrE0gR/10pEHUEI1VUhaQB82kUYr/omf0dO7OZN/nG7Kf8yvErMvukHulBfwcuMyA+Owrwa3h6et9PhQ2K1FqkuJpf9OtT9WgcPIZm2wkVBsLlv/7IkU976f3sJAXpeOBCXBoGnPXWG9m7bZCap0NBO8OxVoH5D8wD46YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMulNgST; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365392cfafso686550e87.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Sep 2024 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542581; x=1726147381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgOzNn37XJnh9r05Bul3VVmu7PlnqW66dmTY+HEc/b0=;
        b=HMulNgSTSPhvxAw82bJ6ERuONzU2gTBC2gV1uuYVoECMLGDtJetnC2SWHiQbxrzKHp
         NmjI0kCvX9YxCwHv/ah+7/BEt0lr3qRQX18IhTAqaOGCyCzd/ESjvAr2zOOL3C2MGv8I
         u/3uOFr+wmasRiW7eybnx9U5rwyDbF0fhxu/rbPHYEqnhobEPC04RwB7huzKFDetCpyL
         wy7TFDXiKKlxs9yck721nXiS58SAM39phSBIpqRhCPsDkqMQKe4wOaO2zB9fmqGtedHb
         f/qpF0EyZSeX5GgR7ZSw2KTEDC1QzBdYBeErTlMDrxz30ztkhs3Z92z38OWrhGpw2HpS
         KWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542581; x=1726147381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgOzNn37XJnh9r05Bul3VVmu7PlnqW66dmTY+HEc/b0=;
        b=OeqeOKQ01uSN8A4uCfjnBygakf9e8KvI3lZUzLvCMqq5NtVTUZEHW8PAZsIlLYtrSM
         N/Nus6xHgJTV0HL5m1YXougv6cKA5pvYaNs8c2EO5mUmNu16hGOei61c+Z3L5Upyn/zp
         4KB1wW1tZao+W46NN8uTcx8ibSOi1SIil8g4B+eFgX53ZB9lHvS9bd91drd573Tk/xEr
         PcMkSZMVrS8q9/PQlf8QeGRL9GqEOFvumdfZYicZPSdjE55L8TTfNZzhk2YgOaLtvJp+
         snyO5MVDA2d4j/wNQbsuN5cqoWhpMn0QojW3TGtZqA5CROIJv2hiJzE57jpGvHubaNY3
         dd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdv5EEynZEHjtxF2mg/LJ+ST2R5/+sFOWcelxJ9yasztvipoPjh4TaebJws8yLlZdBni3S2bQ5+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpya0gdECFVUhLX1xUuxXrsuEpnxJHye1mqyC/aKAqZGJGtFD
	2G6eu5EC5Z/C86Y3kL0LY3ZkXcrfUWHzTI9E/lduNKu6e4IL6YW3JgN0cWBwGck=
X-Google-Smtp-Source: AGHT+IFQNXuLaQLGzDvCoIvfmxCmDxrL6iOajkCgUhh3bCEud0vFaRWrE+nDSh1i5VB6t3aa0vfOqg==
X-Received: by 2002:a05:6512:2c90:b0:535:698e:6e2e with SMTP id 2adb3069b0e04-535698e718dmr3322918e87.18.1725542579933;
        Thu, 05 Sep 2024 06:22:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535681cfa59sm434490e87.187.2024.09.05.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:22:59 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:22:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net, sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de, 
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jassisinghbrar@gmail.com, 
	lee@kernel.org, linus.walleij@linaro.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, broonie@kernel.org, cristian.marussi@arm.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, wim@linux-watchdog.org, linux@roeck-us.net, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@quicinc.com, quic_psodagud@quicinc.com, 
	Praveen Talari <quic_ptalari@quicinc.com>
Subject: Re: [PATCH v2 16/21] dt-bindings: spi: document support for SA8255p
Message-ID: <vk2jiq2rjgz7fdoq65qdhxdx37lbkoe4uq2c2fmu7aiu3c5pmn@l5skg7xvogun>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-17-quic_nkela@quicinc.com>
 <66458a5c-5054-44ac-914f-e66281ee43a9@kernel.org>
 <9394ce8b-9a43-485b-8d7f-33930251ccac@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9394ce8b-9a43-485b-8d7f-33930251ccac@quicinc.com>

On Wed, Sep 04, 2024 at 05:49:40AM GMT, Nikunj Kela wrote:
> 
> On 9/4/2024 12:48 AM, Krzysztof Kozlowski wrote:
> > On 04/09/2024 00:02, Nikunj Kela wrote:
> >> Add compatible representing spi support on SA8255p.
> >>
> >> Clocks and interconnects are being configured in firmware VM
> >> on SA8255p platform, therefore making them optional.
> >>
> >> CC: Praveen Talari <quic_ptalari@quicinc.com>
> >> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> > Also this is incomplete - adding compatible without driver change is not
> > expected. It cannot even work.
> >
> > Best regards,
> > Krzysztof
> 
> Link for CLO branch is provided in I2C patch series. The driver changes
> will soon follow.

So, what's the point of posting the dt-bindings without corresponding
driver changes?

-- 
With best wishes
Dmitry

