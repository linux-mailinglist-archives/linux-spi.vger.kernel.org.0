Return-Path: <linux-spi+bounces-6326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A473A0A596
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158623A73B2
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97331B422A;
	Sat, 11 Jan 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZLouUNi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F82139D
	for <linux-spi@vger.kernel.org>; Sat, 11 Jan 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736623659; cv=none; b=dcRD5yKO4QjoGXQGxOH1pOzMi6FOMJ8LQ7n0MEwXSxKCFF0iS2c9CwHpEaE7S2XakHLIfLeH4Kwt/FH19sxRLLLRSKa2tqOV2CdlKAZLQTuAgexDE0/2C77LIeGe5u+IihoWVklVGsf2SIFxHD+irX0P2KfOcnAzBPg+q92J6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736623659; c=relaxed/simple;
	bh=CfwpKR+2LZXVDs9rJcHICXGzOU2a9Lg/d7i7j7kAkas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m16RxVtc8c6d0zU8UR9A7tjSI+0SRrbUzzOYGJP2sjNO1AhIsi+aMcZGYvDrIvQNGc0xGXltUGZzWQXiUfuIJNuAQoHytaMetmOL4V0O+EfCwqHtpAb7wSJcT9QAXsJLn9WydUGWQb9s1PK6x9BDDO3LclaKti67CrRHc6GFWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZLouUNi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso681153a91.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Jan 2025 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736623658; x=1737228458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfwpKR+2LZXVDs9rJcHICXGzOU2a9Lg/d7i7j7kAkas=;
        b=GZLouUNinoASHib2oUVhvTGxLqb+yfDOVE+osP3WJM9hxFmED5nA8rsMVa0EwYhTUY
         5SkOAcCuzpbP7k9/I+i6qLrBbI2K+rNwnc0HHkV54ZiAfLvqAaJVOpCzHylsTwv5ABFj
         6c6riiOdYp7tgcj++I0z4H7Gz6aT1jRpryhcmxbnbgHz+Zwd6BOiPhffYdf6C8Y+o1Eh
         FtZeX4tlXW9KSLZYrW2F0vzP3uuUHgLB1s4Gw+NMMQRVkSSbrBdBNL6Lh5wAGOUKU9rm
         Sv/2C7Qvr+aCW83s9aH4GCDWaLIAZaG3zKU979FNBASPAr6FzEZ/1nyiYJQavhbSlHIF
         7P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736623658; x=1737228458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfwpKR+2LZXVDs9rJcHICXGzOU2a9Lg/d7i7j7kAkas=;
        b=n/O5f0RsHGFEDyZ31HOsUCiLSo1Ajc6rCkrs38rhaXt6Z/R0LS+PLqCgvTsZu1Pch7
         3dVy0Pzf4Uyrh+bYSjxRozCxIQbesoHkexQEPYNmseQXbPIe4AUn5eOtJmdbOVlOORye
         zQ3M3+QsHWi/mRGYEabppZywYnqSNolVu3DzihvQlslT4eFzzTiRDlKF6HK8urgeaXDv
         joVdEQ6Tj2CYBR0EXL5OgN2l8nUEdqWrOKGUHF33tUjSzFvKry0vT9xzn0+a2ngAEXOt
         oJVCcELOt0dvkFNRZ45hAP6h2OxWPC91/aocQocQOBOyvE6adiNCsbpzTMLRHAC600Q3
         3rRg==
X-Forwarded-Encrypted: i=1; AJvYcCXDRXvL0eDwOuC5AZK1Av9O2VGC/OnLs/DA9veofxtg2UQeDa6fwMrMZsvfdZNhCUJiZK37KTGEmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnUSAju6Evz1fnxNa1DYhyqSOsbBRWeWBq4mX9Wfsmxd8D44C
	nsOgRYK9QM5y5KpbcvdqrbS2DUyrlhG4QxBDUWScs6jxLl064EQBkcOA+uIJhekODKaHhG5sT9N
	pW3XoTPIG9VOVbt3b14y4j+l8f50=
X-Gm-Gg: ASbGncsjfg41r+4c2MFZTFQ5xFwIYwu9aaKATMdWJXF+UqgeVzfyLdswRemWVUjFJ1z
	n0/GrONFl51rFz0Xstme0lEg1rRRowwH03+GCJw==
X-Google-Smtp-Source: AGHT+IGhZwUzkEh+DpckkqR/MjURM5moqDg715p8zsHuYl2YtO5TfToWhx68Yn70vIliBDudFsoCIatJKla+jEhtLG8=
X-Received: by 2002:a17:90a:d887:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f548f1ef1bmr8556990a91.3.1736623657797; Sat, 11 Jan 2025
 11:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
In-Reply-To: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jan 2025 20:27:24 +0100
X-Gm-Features: AbW1kvbCeEX-RVceRqr5kUTnEyvsVpIAE_SIlsCCDcXFsJEw2-aR6KBDnwyi5y0
Message-ID: <CANiq72=6hA20fmBtO_iOTQkk7afUo2Aw9=WLY5kUD8OYgCM5jA@mail.gmail.com>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Mark Brown <broonie@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 8:09=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> After commit e6204f39fe3a ("spi: amd: Drop redundant check"), clang warns=
 (or
> errors with CONFIG_WERROR=3Dy):

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

