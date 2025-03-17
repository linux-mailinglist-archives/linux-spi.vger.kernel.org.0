Return-Path: <linux-spi+bounces-7176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB0A65994
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7D881F8D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969DA186E2D;
	Mon, 17 Mar 2025 16:56:50 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918ADDC1;
	Mon, 17 Mar 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230610; cv=none; b=NcNjeZvLQzYOCBP4Etz6TeFLbYPIP8K2sRLneCXFzMNTtatr7eoUgMYX6LDxi/fMgMLfdCd77ht1n2jIeBs/JRa9/z3QnWQhSu22SosDb3MbzRXXJjJOa8sOgKv4csPyVCehtpYO0G0pepJknjS3wj7f2CLH/qZcJLRJMejD6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230610; c=relaxed/simple;
	bh=lNg+YKmaNgfnAOqS+gV1LJ7ALUkXITJiOmxbd7DO+ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKg91kRenOQTyDBCrufvyIyWoUpJpDGEdvK7wiK/ECKxZ08q1WNN26C2YHM9UruBa4zEHCq33ik7cjL+QJK4kVv7Ol2vT81eTzqVJb+KlQEZqySqA0cGDwTuv5uXl/Em521Ypwb/02teBO5WcxaZ0ASVff2+kvlggvnJ2Ar5CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso893947066b.3;
        Mon, 17 Mar 2025 09:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230607; x=1742835407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/yrKOVgX3sqgkz0yJ1CHb1Vz2o8p8XAT4dp7yUtP54=;
        b=YdY/eEAmodNHTbQIFYRA07Nzx8nxjvFlhzzkeB7PhvT6wSyfQbgC2AhOmN2Mh2lDQp
         tZrW6bUgNF1dpFhTYsD2TSZY1BAEmABCfzM3UhgftoDQgsRxztDuuokOHF0IFN1QNfGV
         ksPHldeJBts+vumUmsAuJJMay+tDX2m8ihpqTJSSF4NBHSFh8VpZNWSQTJSYp360TJrX
         g3h8UxCS7XqIyk/C/4kIJZKXp3osqDkz4AJTFxz/QPbSipf5ckv4mqThxi0+26W8Viii
         T1bXw3pIxflcLKywX4SW8Tl/3wGQa9kG//ELhfm8c/4hcqRVsfmW03YTjEZ0WoCzqayB
         GflQ==
X-Forwarded-Encrypted: i=1; AJvYcCVithQ2/ao6MCZl+xAJWDl0qhO8MeASrnMFV53MZ9aXFCcwz4TNTXk5aA/u4a2JieHcyRweSXv5/geNi1E=@vger.kernel.org, AJvYcCXGGJLa8r8FM2ENfhBELZBOL+DczmQlUi+Mz+AqPcmTSV5R+DDWWYmKSTYt3Ib9CHA1/UiuK43cZYl7@vger.kernel.org, AJvYcCXnnzi9QQvyEOu0Wxcoc4JOkJrlSPYnluOH4eHEy1vJVhN1qkZG06wkei9KjUSM/La1BJwiJBYMqrVskoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwoX8wKExaMYB2e42DwKNH2QRGA9fkVA6Lv2tDzBhUwMFL8rG
	6mGH7Xz+Ia35NBYrC4N7hBq0KChXjoFhQVNsQWObfs+kIQV7DWHy
X-Gm-Gg: ASbGncsYeb3mKcPdR+F5t7jiPKPs8JcIclTStQRl5nZS8v+OS1JF3GtTfmd9vupITCn
	TsrYTJDxMNbI5wXpM7i/hGaBIPavSQRKyJNiOF0q683HmHL5ReP3Er0nPYDCnDfL9nnxtZaJr4n
	Lv80QfaZUVhSuOrVf1ByCRYz9A+BA70gTs2e87TRSM2TqpK1Rv9Yh1H+QIOM+zkYmlGZ9wIhPw1
	TNRafOoFP9FLgajWl/X0iU76CkAE58BC4SewKyeYFJYgTOG2bbmSeYgR9M/TejO+2DSXQYhj0SX
	/tI+8CjwWG9sgzhVXXzllWTTpSBcDMXrEBA=
X-Google-Smtp-Source: AGHT+IG8NndXA7j8sjAS7sc+Uis9dmu6gXb0Jizp5hoiuZJltFT2290lmqJaMq3XRzdJFZvIjdh0fw==
X-Received: by 2002:a17:907:7ba9:b0:ac1:daba:c6c with SMTP id a640c23a62f3a-ac38d412666mr46132566b.24.1742230606651;
        Mon, 17 Mar 2025 09:56:46 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e7f11sm689087266b.42.2025.03.17.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:56:46 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:56:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250317-solemn-debonair-sambar-f04fa7@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>

Hello Mark,

On Mon, Mar 17, 2025 at 04:45:31PM +0000, Mark Brown wrote:
> On Mon, Mar 17, 2025 at 08:44:01AM -0700, Breno Leitao wrote:
> > My UEFI machines with tegra210-quad consistently report "device reset
> > failed". Investigation showed this isn't an actual failure
> > - __device_reset() returns -ENOENT because ACPI has no "*_RST" method.
> 
> That's not the case, it's returning an error because there is no reset
> controller discoverable via any mechanism. 
>

Sorry, I was not very familiar with this subsystem, but I chase down
__device_reset(), and I found the return was coming from:

	int __device_reset(struct device *dev, bool optional)
	{
		acpi_handle handle = ACPI_HANDLE(dev);
		if (handle) {
			if (!acpi_has_method(handle, "_RST"))
				return optional ? 0 : -ENOENT;


> There's no specific handling for ACPI here.  

Do you mean no _RST method as stated above?

> It's also not clear that this is a false positive, the
> driver did indeed fail to reset the device and especially for the error
> handling case that seems like relevant information.

If the driver failed to reset the device, then device_reset_optional()
it will return an error code, but it will not return an error code if
the RST method is not found, right?

Sorry, if I am mis-understading the code here.

> At the very least the changelog should be clarified.

What would you add to the changelog to make this clear?

Thanks for the quick review!
--breno

