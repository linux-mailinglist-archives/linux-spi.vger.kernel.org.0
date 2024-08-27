Return-Path: <linux-spi+bounces-4339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE01F961542
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBDFB210BB
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BE1CDA1B;
	Tue, 27 Aug 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gu0qoPTc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24091CC163
	for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778916; cv=none; b=tfVIEQ1Ape9qBBRX3gAkLoEZtl6yNIbjQ1UuFz5Uc1axez2E73j974bIW/e0BSoZK6bIU4Q3qE/be2SRgWFvfNzlOPBObuiyd+9FBwAPYPBZDJggBCAK7sGG5VhbXmwXwWqgR+omyNfhh7z1o6xcDBKN93Ew4W8u4Wb2rAmYRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778916; c=relaxed/simple;
	bh=yuG7e3Eg/etiMyl4TH2Dl9QyRGreunb9m3Mr7X/9BAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pfj9Nw5iAfYHQzeBCMJHBc3YWqCPooKnic36ChmcL+drkbpzhfZrXKA4bSs6L7ZXYpIgCh7MfEeNlcnSWmqJGFsUivl70H/CVHtf8gx20rQjy3Cu4Z329gFaXu397Y5SDtHEVRTKyuZ9Q4tJigGmicqTWqGnf0SMDyw0ZtixkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gu0qoPTc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42816ca797fso51856895e9.2
        for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724778913; x=1725383713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuG7e3Eg/etiMyl4TH2Dl9QyRGreunb9m3Mr7X/9BAE=;
        b=gu0qoPTcS9vYxeubplZGw+nopyiPfmxhPjqBxseSlSL4ZmUxDXBh6OEQMwJlwfYwdH
         NDoVrbRBrY6d+pVrwXkiE9vnfciZc7i8Q7Zh39FzL7jAuPZ7ArTrwSKZxr/AbwMQkmeN
         7/g9TLr9+f+opi75tSjuKwR6TgRm1hm2KHT/1LJC+JDsInkmnxNnxzAz9w0SUU3LRCXz
         5QKGtgJSEVjacFMQLotGeheWfQ81iNJvHC7G4V7+0ephVwmr9q+D9j+ugTHltvEXXiuS
         hyFCaT3pcrbV3G7FR7ri9vo8rP2gbYzDu7flMphi2HfdYqokktRNhth5/NBk3hXyNDCx
         niow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778913; x=1725383713;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuG7e3Eg/etiMyl4TH2Dl9QyRGreunb9m3Mr7X/9BAE=;
        b=FuikT5XiqW2z9sS6Zz6favjLps+xhS6r3DILaG3S/LEsKRHw6tjLm8zSO5MHPVVHWf
         Mz5y48H3DrVo0L7VCvRgss/NTHGWABS2XLJo1QYudhDeDZ82s0j10wZoY6kvKkadAkhT
         nlwcS/gyqz1wX4V5TrcW99xa/nbcpl0zqNUmvLCwkrKAOfYjLBSl+wgwasYC1pBXkKJw
         6gm2+UYHMrkc5P8uwRX1zc+JrupK5ptxwTKqw0NjWXz3xONSkVFmDQ3kqYE5sHzeQT9i
         jfYAUvhDOZ7ZGbzHbd/l1dPB1Pt1TPqbKMVOvGhyLVTTXxYlFNYAeNjjXoeh6i9Eaa9i
         guEA==
X-Forwarded-Encrypted: i=1; AJvYcCXAoznel/mbQS7YAT3IxxlCU8EwflYw6mdvCjPdNFzO9p/jBqfsgyMtQrkbFLtOeNM+Ho/+kPP99kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3DGJ79zehOiGIqkR3qEFEc//pyG/t6S1FHbRQxVq1EhDq9r0
	SyE2orRYE047PkoQjm3xePvc9Srb4D9Y6ozLH7JCKM8OmlY638KUYi3P8EQFMBk=
X-Google-Smtp-Source: AGHT+IGK0xctQQuh1D1COxlMsGCOuBCV6tv4rvOtsNSvyQ2yk+aDZbwX0OHQqf3bdMz0aGaJZEc8UA==
X-Received: by 2002:a05:600c:3b90:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-42b9add43cemr22599875e9.11.1724778912791;
        Tue, 27 Aug 2024 10:15:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815c90esm13633844f8f.56.2024.08.27.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:15:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 531E75F9E6;
	Tue, 27 Aug 2024 18:15:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org,  Haixu Cui <quic_haixcui@quicinc.com>,
  Mark Brown <broonie@kernel.org>,  Viresh Kumar <viresh.kumar@linaro.org>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  quic_ztu@quicinc.com,  Matti Moell <Matti.Moell@opensynergy.com>,
  Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v3 1/3] virtio: Add ID for virtio SPI.
In-Reply-To: <20240326112812.31739-2-Harald.Mommer@opensynergy.com> (Harald
	Mommer's message of "Tue, 26 Mar 2024 12:28:10 +0100")
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
	<20240326112812.31739-2-Harald.Mommer@opensynergy.com>
Date: Tue, 27 Aug 2024 18:15:11 +0100
Message-ID: <87y14h51ls.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harald Mommer <Harald.Mommer@opensynergy.com> writes:

> From: Harald Mommer <harald.mommer@opensynergy.com>
>
> Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.
>
> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

