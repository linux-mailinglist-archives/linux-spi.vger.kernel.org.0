Return-Path: <linux-spi+bounces-3582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D5E917010
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93ECF1C20D24
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11D1779BA;
	Tue, 25 Jun 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN/TNLwE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F616177991
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339737; cv=none; b=cmntTY78NKR3QoLqiO5wcR0DJtsMUAyn0oe4iokS7nznGc65Iw7YYh6C6YQpQ0Nj2enBFqXgYSNDx8QcsW4B3N02VXqUjE8rRTXdH14SiZdDPv2csMrWqAu/kqQF7x/o9iWcDNjyM7kPSWbbplO461lpFT+03Q2AWo5u7Fwle04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339737; c=relaxed/simple;
	bh=+Wb6iZefNVOd3tYPc9UfiJtaRkn0FejoDq3O0aUm0aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgB8FGUzF4nAl9XwDRDlvRqsCWO+/Jz2I7DNmQkLApsauCwcvz41f/LAdZQ7U0t/46PKzMH+lU+4UNyjqefuP94D0mh6VC71xqznCIyOsnk78h5gKFfP4+TVUYGW7+3TZdOSvwx+HzhfqIx4e41/D4G9Yo50jOrHBG5Jk1THbdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN/TNLwE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2e736dfdeso825719a91.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719339736; x=1719944536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JsB6ZwQpf3cWUiXBUR7QNnClf9lxc5ZTBhUW7Q42nY=;
        b=XN/TNLwEUVMKTd/i5e9viC49m3cczua5K/G3yEwwdvArDWRr7zfGaAOG8QC5UEEjVV
         WWvgKFzuzgCnRNLwrqjgqNu86yeA4dgBi10VFqm2bzQ3lkH8Cb2i4r891Nfxn6WkTjIz
         LeW8qBJDyAPTgzGlrOcGrmiese5K9+OD8qT3a2ZBJo+1xZeGIO8hFUaZPJdFbgCOABbN
         jQT7M6cjt6CZAZMqXV4aymVRX/vJFxffcSB0/2hvyuQr9fqDecBi3hk+kMxAfUpdMuF6
         rlCmzECtByEgu5tRkiNdUN91pw1balkjhMuV2hcXukMFRtExyYiuPoRT0XCjMZaeek/6
         cSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339736; x=1719944536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JsB6ZwQpf3cWUiXBUR7QNnClf9lxc5ZTBhUW7Q42nY=;
        b=t5RhmtgdvagY4VPuxlulx+gcO04kkGp2gaREljgIBhBoRGVndNkLVh1CmjMGCPUBdk
         FIgo/F3I63+5KvoP++lqKyUJbePIM6X3IS1NxUtJWrYI/zLH7SHxGhr7aYvzvHM/kxcr
         BccFfPCqe9PjAu9YNzZr215bPugofpb02CjrTIa6N5c/9AOF/kx9U0h5iGpxuJCEvax/
         7jogU/ptVnlqtQ1Xnb062p6P9LoUsXP3d6UisSIoYD4y7aN8889WK92Yhe87hil0HRQn
         ydih73V3kcOksK5XGKbivZeLPNYvB3GAU5yxVwsOagnqJazg4kUNz6a3OpoFqRELYjxb
         /c8w==
X-Gm-Message-State: AOJu0YzxSrFmDsl7PukwB+hjIfnIIEYVFfFORvjdzpjibHoqCG58iorO
	9Fv6ieUUdvnjvrr43/uUc8XCNSyaZX/3IDn20mCbHkw4jJTBO+EfQ21tqwIteHV70s9JCLRnWsu
	OPhVL8D52q3mZp/5/8W5an9BqzoWXuw==
X-Google-Smtp-Source: AGHT+IGMv/LZIORaYkUqqGWi3PyBl9jXKhyAmsqcX3gHUawQSnt/tnci60VaM4J6zYB+D+/QrTzjcWYh6Ukz6f4qn18=
X-Received: by 2002:a17:90a:fb94:b0:2c8:4623:66cd with SMTP id
 98e67ed59e1d1-2c846236d22mr8767099a91.1.1719339735879; Tue, 25 Jun 2024
 11:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002023.228235-1-festevam@gmail.com> <171933915475.1078311.10439532819634651237.b4-ty@kernel.org>
In-Reply-To: <171933915475.1078311.10439532819634651237.b4-ty@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Jun 2024 15:22:04 -0300
Message-ID: <CAOMZO5CahzdBb3+J_+voJ0u_k-oS-toFarNL8dxbHqdJJx+1jQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:12=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:

> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-ne=
xt
>
> Thanks!
>
> [1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
>       commit: a93f089ccf823dcb9cf678969e127047762a1473
> [2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
>       commit: 6765e859fac9acdc1265b6f16ed33f42317ed30e

Please apply v2 instead of v1.

Thanks

