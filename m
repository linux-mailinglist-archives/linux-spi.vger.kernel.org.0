Return-Path: <linux-spi+bounces-2701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6428B9630
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28939B22632
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F1928DBC;
	Thu,  2 May 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDk0OmGm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E622E657
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637514; cv=none; b=H7gO3ouqk4zroEWDNtO/oZqt/7xZXtTSM/xmczsGXENnbXxXr8wG3K8HO2rsMndfW/TWSjuDhkF0AcqZwt3OcpjFHJMcJv1bZhiFZRByGlZUuAUo9WILVblhFLN3YgyVRgwWGyYIVraxNrHEAbmHLMcw0q37iokFBl3WDZgevU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637514; c=relaxed/simple;
	bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsNDMwXKzzJXUjqjbxmrOuOtfHJwhKP7n5oV7NQNoT94nV8FkBh4h85eA3m7aX2PzBZyMO7XlRxd79j/O9kMsEoXK+RBkkuNtLND/nA+1RjD4Sh+BbSnTo9h7Nbn5k5jyY8020ACSsEvMkCcuwXKXETvNbaProQHxvbneV10mdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDk0OmGm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de610800da0so3160776276.2
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637512; x=1715242312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
        b=PDk0OmGm8t5aM5t14gcwG3Ns9+q+FlgldEFuaTJWpdmUzxlxLvRStW3u5W05ShjTgV
         U12D8UUivYnklqVL7agFZEp6J1xd5qUUrs1NHHjOtObqFEYoDYzRWL9iLZ2erPyveGeg
         37ArbxJFltrYqhG5tG1onGW2xTpMEHKruII1KKBO8fjDWtk+zwOL7UO7mV8L2nws+M3N
         ubBFb5zT8EplYBGuSdhu3T3GKunNq8A7El9wFw2miyMxhgq1oGyLw/Oq6USmKHJpjlat
         z+5cIqAnrmwnJuj6ITewXWRLyyT7tcOFtzYoZQv0sUC+a8EoK2FBtOixqw2yGbykrdCE
         ujcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637512; x=1715242312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxkLqxQzKhgz4GC9Gf06h2iC/l3nC8wOfhxYa15iJUw=;
        b=K4VwrwuN9zpqkYkmdfQDZgD3xZ6eNkSq0S10aajO8kydyjbhqILBLp5NTuqqs51/t/
         r12QvwGjwg6HaI54zTNSCTaiZTh5k63RD5MbDEpq+PeH5b7Hub3fjDYMuu44A5SRJf9C
         jPm2qCTH7J2dUUqazc3970BzsMzquByF3Qu/kx3yIiKd2mm4ZvS6TtWihjeh/D7gtd0d
         E4P8SGbrpBKMc45IiaAYAfPGGPVyHvNOoPRVUmQlR5VWzR/pQ5aqwcAczsTn39l7RKDJ
         4NbSoGhOaQkQbJZRYK5BoTte8dHSQTRbpigQiaLlB6nhwH4Wg+NrQSM/Rv0PJqgMH1Tr
         pN2g==
X-Forwarded-Encrypted: i=1; AJvYcCXx8zKIf3NLmIm7mJjq26Ps6PvEADlEU9U66i4+YvIucPG8wgOt9O/gGix+wla5/i75cGSFN+CqTlzgF2Y942nmRLztGKXlZQ+q
X-Gm-Message-State: AOJu0YykXGA9NFnhZs2di/JUKd0/fvduZBjzQB10z9alJ9IeQItPP4mT
	brmf93O1jK3GJqiOhL7G50y9fGZ1Ir+pjJyY5OsqvebC6EAVkPDkPcKNKCWGDyLkdMem4Yhq3QP
	G9Mwb5URYvabjLqoKnV2NJP7rCAmVTFWZFdg4NQ==
X-Google-Smtp-Source: AGHT+IGhjPNgECD7yDSeleITFfk/B4zYUZteAUhS1Lgf3atsjCBfVHl7o0e4W3MEUJPn8a0m2qQCHm05xC1M/8Hy+QA=
X-Received: by 2002:a25:ae9d:0:b0:de4:6ef8:2778 with SMTP id
 b29-20020a25ae9d000000b00de46ef82778mr1528694ybj.29.1714637512103; Thu, 02
 May 2024 01:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:11:40 +0200
Message-ID: <CACRpkdaCLNO4XvOYk2NM2vX5uH1UP8KsAKmivmf2HO5Dd0yppg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] spi: pxa2xx: Remove timeout field from struct chip_data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The timeout field is used only once and assigned to a predefined
> constant. Replace all that by using the constant directly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

