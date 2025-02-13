Return-Path: <linux-spi+bounces-6809-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4DA34EA4
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 20:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C49D3AB2FC
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913C3208992;
	Thu, 13 Feb 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPGAOqBg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07478201100;
	Thu, 13 Feb 2025 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476079; cv=none; b=U6uz4HCJj/NAnRcdJgw/GEngc0o9KWSu9BlKzZlK9rF6X1U/BFAIKEBjxLbn178tskBnjVQh27nPgQzVf0HhTjgtdVoqBGXGvfayXFkNxn3z60sTYbMHe4zZX0QblilVFHtxSg3hel+H4pe+4/iCzQHlzt4WLlTRSIYkVnQ2hao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476079; c=relaxed/simple;
	bh=WkGskC06wVsS+V4YhoGHGuUZXjLzmZ72ZPFNMA/fYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPWDf0gIwJenf/4bYTKlTy9s0kEu4Tg8GtNuUtAADKVoyuKs7bRm4hQj1X93wLk9Lj3FuV6uq7inrk6jchEP+LOkOILLNQNqRmkQmtz6MiHAve12h+r9jFrrxBNkaGy2cuV/0dklnpxhSvo7rThhjgiqRis9hjgFQsNgJ99Ns9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPGAOqBg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b86e13e978so698915fac.2;
        Thu, 13 Feb 2025 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476077; x=1740080877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgc8m2ffW0K8m7hNVPYrvZDbb5H5c3q0ozQ5Jpfyw6M=;
        b=ZPGAOqBgYo2ZrsanuHX1hAZS2S4oVYK8bfNaAno8FM6tMjgs1gcCrCcJcHyeAuK8jj
         vff/V4QHKFdLjy2uE8JjniTS9n6m9K9L1kJJtb9voz12+uNs62nVHR5by80aNCJc0cKg
         v6s+aytgFQvUm518nXKxN0WFQprN7uL9cb1UQl2U/7O1eoKcdx2vxpFYF1PMcTvSMu02
         H2FXbM2Vssirbz1bbfizIPMA5Ij0pz3Thv/pfe74W4OsbWm6IvSJSybQC4buaFwRfmgd
         WFi8QN50XRfcci5GmOKPzCBe9CbSDi0PQjbN9XTxuqlLvV+umnIX0yx1TKe05X3yR0Ku
         l55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476077; x=1740080877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgc8m2ffW0K8m7hNVPYrvZDbb5H5c3q0ozQ5Jpfyw6M=;
        b=Zj2q4Fd6cPyH2/74bxLyj9vLe79/J/arxJZEoTZDvl0eS5GpvawL1zzDc4TGusDAic
         DMG7Losb+JuBPE/CrakNhudyP02ExPlEyIHJBP5ZmKsT9CgheTtO2VVO0a2VMskA+zqg
         4/fvPDyIe8UxgLLw9izONcX8SOhznV+LUd1R3auncryCi5yseEAoar8GiEQ/MM7pn+ie
         KpwpsnENzR2VkhFFWSuo6r0K9ttKMEORO/HS1ZvHXUNOsRCtLboMcYI6RK+JZhFnVu26
         jchHxBxH9hFpP6k/2DynZwLfnTEwA4uaqeYTQEjbNypQkFVo0Mt/vsrsMH4TKBXXRvSa
         t0vw==
X-Forwarded-Encrypted: i=1; AJvYcCUR1falV+Dn9RcUEzzV+EgCHsCivjr7Sj50WUMfPnh/lbuC0f/5a0Ll9bHlXooHpjaseu7qz6PcvBuJ@vger.kernel.org, AJvYcCUfHDOl7lAoZerKWGqdGzzGL8Qp0zkhH2DaNVy5oczkyFMRBO7y/+d9VqPncL5VbqshTwd5vAysXQP5@vger.kernel.org, AJvYcCUl4vpO6qZYbzFPMWMtDgouUzHQZBRGfkIPQHzN9IRw/kJegjm/63xXWjqnnuymkvePhc4pQXpWSuaXz62l@vger.kernel.org, AJvYcCWq//PtxqXN2D+Kd1HdkGFsqEsObvNUkGzVlLPdD83eDwrwinkdVPGNOL3BuzNlMZ7hvYkA9E5nXIxJtjV3UMh0iYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRlU7eH9f/biwEi0HWvU+5o5PRCjh7J+9Yor/HAiC0fDtZGjC
	xPc58Y/DGpZGY/CKzcEk1fXz819FFXXO9pdcAExISSZaUJWXHAFV
X-Gm-Gg: ASbGncsKJs/H1omvTbkP0JcHHXzRSQZKR1c6aEiTMx9fJlRXLK4WjgROb2BfIQ+XSWS
	k6r5zt+LUrtowDVzvysVWaYQtaCjfzaDp1GkZPaf6VussCBtBukgzQr4W/xXz0Ry0cxS/uYScbI
	mE5edmfbFCY69vEFYhGEF8w+J/wdyRP3g5siczz78YM4XKfJGh3vjKezUIBHODPZ7rYQnA+cgGV
	io88QasjgeQKEoswAeN5BVTgYyXKaTz2WeLeurpAf6pI61FswhKMWFg90ajDQdkOOHHS13iMuwp
	dHqoFYi5GMLHmnjz8Rj89lbvoYlhj9ZF7m5/wS1B4/2vlnRdIzQvT0MkjKjHwQ==
X-Google-Smtp-Source: AGHT+IH40VRoRAnhhkBrdBVL3wpw5PZCEeEg4F12l8trpqePnOjbk6m3KtGHvVNpBjAdLQge2XaEhA==
X-Received: by 2002:a05:6871:7b0a:b0:284:ff51:58ad with SMTP id 586e51a60fabf-2b8daf08a71mr5152420fac.27.1739476076940;
        Thu, 13 Feb 2025 11:47:56 -0800 (PST)
Received: from droid-r8s ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95a6bf7b3sm1049692fac.32.2025.02.13.11.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:47:56 -0800 (PST)
Date: Thu, 13 Feb 2025 19:47:45 +0000
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alim.akhtar@samsung.com, andi.shyti@kernel.org,
	andre.draszik@linaro.org, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	peter.griffin@linaro.org, robh@kernel.org,
	wachiturroxd150@gmail.com
Subject: Re: [PATCH v1 0/2] spi: s3c64xx: add support for
 samsung,exynos990-spi
Message-ID: <Z65MYSNuDdCFNlv6@droid-r8s>
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
 <bad7b5b6-c61b-4e93-9415-6476976c8e81@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad7b5b6-c61b-4e93-9415-6476976c8e81@linaro.org>

On Thu, Feb 13, 2025 at 07:05:22AM +0000, Tudor Ambarus wrote:
> gs101 mandates 32-bit accesses too.

Also in exynos990 [0]

> > the SPI node where it will have to be specified in DT (Device Tree).
> 
> gs101 has some USI nodes that can work only in uart mode and indeed the
> fifosize there is 256. Does downstream define SPI nodes with 256 bytes
> FIFOs? Can you please point me the the downstream code?
> 

Yes, Exynos990 has SPI nodes with 256-byte FIFOs, and you can see this in
the downstream kernel. Here are some relevant references:

- SPI8: [1]
- SPI9: [2]
- SPI10: [3]

Best regards,
Denzeel

[0] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/drivers/spi/spi-s3c64xx.c#L767
[1] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L1641
[2] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L1662
[3] https://github.com/pascua28/android_kernel_samsung_s20fe/blob/3be539e9cd22b89ba3cc8282945a0c46ff27341d/arch/arm64/boot/dts/exynos/exynos9830-usi.dtsi#L1683

