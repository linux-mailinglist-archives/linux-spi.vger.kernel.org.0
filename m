Return-Path: <linux-spi+bounces-668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE2839916
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 20:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560CE296708
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851B129A85;
	Tue, 23 Jan 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv1+sAfN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F3129A6F
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036440; cv=none; b=OImi+xF8NAZdOutj+KwoVsJL5k/DzLQLyKmGVWpDuhqlQa0LxAYjp7bQ3UQKDLKyvZtILUwHFeF/reDQnfP+s5O5hKOL8n4Wys8oERYDapDUdDVtgmfswLqOM6e5fCEV2ZT+MkkF2NgSwlRdPl4rWpeaKhubAPT0Je3NbRTNmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036440; c=relaxed/simple;
	bh=ZKIUReDJHL8PnaXbcu3q7fLjNP7xT5ogthRdWpyN2Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M38jeIA6A/12RRoiA+WPDVf5+Pts0eOPm5JuonMsBe9lMLYckTwTUDVJ2cPmscw52gU1hgTzQNIaPEEjXe97RkytSVYOr+xfquZJpLgcDSn4H8GLIaCm+EBsszQRK3fwoXjWk7K0p1FnXxPiwZ75iQ1LHzLnlH7AK9yoUI1U2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gv1+sAfN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2422847a12.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706036437; x=1706641237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmD7dH3qV8pv67RKjqLHiAxOFddNPr4ehUigPqKBvas=;
        b=Gv1+sAfN9oQ3ohxET0P9VDHpRQAScBVhCmZBc7zYVHpZsHYZUKmv/zdyjt9WEKgZUC
         zxPwGNyddiGL1WMgPYI5ISVdReZtuDL6NuVZg/OrJLfog33zn6lejW9cdM1B3MuNpxGP
         mCDO83y6C53ZboG0jqDd8C2WGM2c2ykc4OrtNLlQk+90cOZOKugEbccgQbAbpGhJk0xD
         Zu6ENNWKGnAQfQz12L7ds3RmjzbdWm0HJLGoEP14AHgr/Z8dpmiCaXJHWWXNEWXE+3nY
         mywZEP2Ckp1jT5UKZp0arJL0mRXqfef5ok6DGc9RZG4hs/AfijlhgWmiymEjVcN/WeP2
         xcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036437; x=1706641237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmD7dH3qV8pv67RKjqLHiAxOFddNPr4ehUigPqKBvas=;
        b=n6Dabi37TaRidP8NH2UoWXk7Eshc7Ou2tE7wbi5MoTdPlsNEr97btLYDyA8l2haKlU
         nDaimtg3c+RLglX71MuAtU6xV4ZggYcyboqOYV2rHEtUPc8DvdQ7PMYl9d/IgT3+G5jG
         dnYZSC3pKG9uigMvwxmVASpb8WX6upVeHarnBGXD+iMCAW5ie1+Cqbk3WQ7lh3swAdQ3
         +h0A+xf+hORhYCQ1abgs+lCVvXcmlgAYTAWCNRnDtwlovlRLOjVyM3WMzkbhgKu487WW
         DvZju8yFF3dh0bSVrSCo62/lpDD+MHgKDP3rD6SF91qATg3VeI40krxrJw+CgXdBT7Z1
         DwXA==
X-Gm-Message-State: AOJu0YzxmyDas6YP8OBsFqCbTjQhbtvp4yNRnKsxQM+DFU4Pj9WNC+1P
	kiyMVmyo9XOYvqyBbGmw2Je/8WUzWm+Vcyjdh/PWzR+TFF07nBbrOsbg1OSaB/btfygqJ3h+qID
	A6qS3TqWQYz5TOJliM+FqT+2zQIReh1XEw2py/Q==
X-Google-Smtp-Source: AGHT+IFtt2avi3/WFpubHex5rv8MfO7wLgxXcE6UTmcf3PTwqa8lOjnkVcGgZpxjZjETxZcvz2YZkN830u6srUK93C4=
X-Received: by 2002:a05:6a20:3d95:b0:19b:1da3:cb99 with SMTP id
 s21-20020a056a203d9500b0019b1da3cb99mr3801518pzi.5.1706036435251; Tue, 23 Jan
 2024 11:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-22-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-22-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:00:24 -0600
Message-ID: <CAPLW+4=dtRQT3QMfXLPE_0=TfANTZVa-Jm1Kt9CVTH64hUsGCA@mail.gmail.com>
Subject: Re: [PATCH 21/21] MAINTAINERS: add Tudor Ambarus as R for the samsung
 SPI driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> I'm working with the samsung SPI driver and I'd like to review further
> patches on this driver. Add myself as reviewer.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..b9cde7ed8489 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19404,6 +19404,7 @@ F:      include/linux/clk/samsung.h
>
>  SAMSUNG SPI DRIVERS
>  M:     Andi Shyti <andi.shyti@kernel.org>
> +R:     Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:     linux-spi@vger.kernel.org
>  L:     linux-samsung-soc@vger.kernel.org
>  S:     Maintained
> --
> 2.43.0.429.g432eaa2c6b-goog
>

