Return-Path: <linux-spi+bounces-10018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19AB57447
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 11:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9947816CC66
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074062F28EB;
	Mon, 15 Sep 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3Bjprbw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E932F1FEC
	for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927677; cv=none; b=N4NT+k5in0PlScUbbxLPv1wbmxN873+K26ifiBAsexjPKI8SAQCvnN4Wq6uc6Mkm57Et3zoRJ8H2Qev7QTYA8/YVVBgSTt8ed0Scy+p/QRRqjwdzmpsPgWDNNq8cBZDbDDlSeKoM156I1pit6MG6cBxfE2bgjyV4hRv4voUczgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927677; c=relaxed/simple;
	bh=KmJnxss+MoY7NrV8YJ1jLGKE3+2RMVeAE6TDsl1qkWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbUHJukJbvPtT+vuaMR6x4duRa16EZ0tuWN1ShMiCh99Z4dCtRrq6qfMTzj7y1mrWvGK1Jjun7q4ZgSUANbao5Z4Om92vmd+6F4IC1bebpVcQXxyhRuLLEYKg6a8lF0BJUYtnLPXYXmvlaMDvuzWoqIJcgMqOVf9Fk+53ixzCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3Bjprbw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso4551695e9.0
        for <linux-spi@vger.kernel.org>; Mon, 15 Sep 2025 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757927674; x=1758532474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aku+CpnvWW9zhF6+nPeIxknoBC5KeYin4IOVLZZ/1pw=;
        b=S3BjprbwnbQU6XcqP5P+Zvo7Aas9yso/B+OpSv9rTj/9QzlJC0VSumIHd1Y8DIczhp
         KtC53YgreatyzbudzsVo2WlawgN7P2goKo89P2d04wnqPeD4z8nlxXejUHTA3PT4mhzi
         iggN2G6vJ1jhxzyRhPYQlJDCdQplE8Jx+qGU+IHiuvV7NZ6E4mfsM70m3goEOvZsqLJJ
         7erq4shgI54JCBitvnsAeIhkY/Ak30UyaMSVLpf38mniM1lz4bxucmozDehFtegbesZ2
         vFS0LOEC3FrhWsKx1wiLgatz40s+jbZEJjl8ja8PUloldRbTx4UIrhBCm5lAtAG8sOxu
         ob4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927674; x=1758532474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aku+CpnvWW9zhF6+nPeIxknoBC5KeYin4IOVLZZ/1pw=;
        b=SluUS9lSsiAxzWqkaaRieqmOtbNLfghS4UBHrAcJikVI6AR2c6PN7uqRICA1jZE8/7
         rmb6DGDsuF6nmEhoQzZ6V29+dzfMI2wf/rw3yOeQLUMKrMciYoayOP5vR6WQXyPkpHC+
         0K0vkyU2W6mSvUSuzy4bXZDVeBtTc0nFUXIRurZom3vO/N4BMgjP1cSZewCoFL+Mgv2U
         Ovxf4c7UKIgMDW+W47zs6euQ2NMb4Es6L7jASiICUIFUt2WOuAOEc72mxaI9kuc1xqdQ
         dtqVlnavdl54MQYW2phBGD/+j2tryWecoU5AJKtCTITUfSmpoKHXB87CNt36wqWmnG/H
         tGiA==
X-Forwarded-Encrypted: i=1; AJvYcCVHxzCbAXY6c047NgsmzRMXa5JgSfW/O82A6F/rT/H7ADoLGUfi97O5p96sgILL6w6fb1OapIYYo24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJh+dyubdOtfEYh1MOC+r/vqU7+9D2xYz5btLjunBgrAArQtis
	fmuRanmeOa0YCjrMeOt0epoxgieC9lYGUYDFVBT5bbjB6T48WxIi4hEMRJn83bI1uutMXkwAqh7
	LWEM5diY=
X-Gm-Gg: ASbGncvzRvHuXpJPD1H7vu70NyhvJHUTqvUe3enRaVoZsZ+QyByUoIDSwkYYZ8ZWqs4
	TziBvyOSO1E4LHu7hyu4Ro89snZE+eeHO7kuhgyB1Shly75MlXkJpTlFlFh3gvhnfURXrqUy98o
	82OqgPt6oS1jHw1wG+F57mmA6sU5nwX9TJ3kfkcGIDWa7Tl48zxSyFm/eF44+8oe3r2Z60QpB68
	eihtWSgataJ9p1WhP6685ITL6yoc343BTo7lZj/9Q8ZiLvqVf9TDbFzX+TyC6PiO18zGs7mZjM1
	IxAAdqPEjK4ddEZOsD4VAkwTZHzY2fnliy8w5KNhfLClJWsKTiqlg+WJTI25qmpxzAdrgBIHcZO
	r5y8f9PVhTOpzwnvV0vn0Tj81Wkk=
X-Google-Smtp-Source: AGHT+IGfbN1nly0tHEF/LPKTpBacJhCDeNphPgRpeP/LXLn8yUoq10STJSdN75g2RpiF61gi81auIw==
X-Received: by 2002:a05:600c:3b1f:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-45f2130999emr113157655e9.18.1757927674493;
        Mon, 15 Sep 2025 02:14:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e017bfd14sm170533075e9.21.2025.09.15.02.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:14:34 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:14:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Feng Chen <feng.chen@amlogic.com>
Cc: Liang Yang <liang.yang@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] spi: amlogic: Fix some error checking in
 aml_sfc_dma_buffer_setup()
Message-ID: <aMfY9P3L0yWdWe6-@stanley.mountain>
References: <aMepB7E95kwYvx0o@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMepB7E95kwYvx0o@stanley.mountain>

On Mon, Sep 15, 2025 at 08:49:59AM +0300, Dan Carpenter wrote:
> There was supposed to be a "ret = " assignment here but it was
> accidentally left off so the error checking doesn't work.
> 
> Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Sorry, I should have checked lore before I sent this.  It's already been
patched.

regards,
dan carpenter


