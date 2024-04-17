Return-Path: <linux-spi+bounces-2408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DC8A81AB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 13:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80C128701B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 11:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CC13C825;
	Wed, 17 Apr 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGO28q/j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5813C838
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351980; cv=none; b=OwowKduYZC0vZ8Cx1uMJ6cRL3R1hp1J7+3Vrz62+N0vqmhyVue9UUk721cwHERh2u4EJSCoxB5osRKzdH+6ZWlTSEy59W/ShG9sD5TvFlfltsNQkxK5EMyvm4eAkdrZ7nMfJyIGrWi3SuM7OAH9ujBbNtEpK/Js/oknY4Mcjp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351980; c=relaxed/simple;
	bh=QLisSLf0Brs+OJ3+l+UtrDdazQHkr9U84wUYbEIXlUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NS2YYo5JMMuoNENdL+l0kA4FssAc0CnfeEHD0l7ZehGoaXFtM0LKWe24Y7NGbAH/DKluz70OT7Cs8FEq83CUrLOeZ5mOo8K2vzaLB0wGr6A5RioCZjJJ5ZD+/ntrtISwLP50xmJoDBbuAG3CVQcuF93AO3OxlNzD3ybElQdNItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGO28q/j; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so421553a12.0
        for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713351977; x=1713956777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLisSLf0Brs+OJ3+l+UtrDdazQHkr9U84wUYbEIXlUc=;
        b=NGO28q/jWexwwTyzGjYlqOJTYh7HP5elGy+ZdO2I/EjiKG/9yhiOZOKoVu9/BZaqf8
         /+a0WxdsrxNzSElhOz0m4dSPqYAjyYRYj6KIaLJFJ/a33aCGpBW4kDYZAW4Rrwnx07ft
         fKwGdfpHDPhTw4c2KxNPVMPWpjlJPgp/2FN5S20hiG8CrhTHlY3yVJQ3aQRXbXiDp/Q4
         n9Mx+9fh+wSRDGAHflKRWKQ56hY6ls1ZSGARyLPXQmwth1FhRxdRc7mQAgji+ZL0I6n4
         oK4w8QQyxP8KtkRpeLpjkrJf4nTIjQbN6F7nLJ2T1EsEJPNKgLK/Jo3afPkc+btvyubp
         YJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713351977; x=1713956777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLisSLf0Brs+OJ3+l+UtrDdazQHkr9U84wUYbEIXlUc=;
        b=F9SVajMifveoM5K9BH161VoXb7hHpPvWIB3lT/FrL3SXsKlk3AIw2Nhu6Y2eLxGr8e
         AefWz2BWlqt1OAnaLIb7D2IQL/ruoDRPzYXAR6TV5+5vQBURLvDgrgmYSck/res0rjFs
         9MYOui5gv/tOye58w1xGwcRR4DOPfYMyG+J2PP5zx/7ObWpm+v8DodBzLq7wHIShcYkQ
         iXR8F16VTKksrSbeZKfG+zgeE8TNiKSREsFyUAcNCGm4cynv1/WJgWcJ3ZyKIMaNATFc
         vzsN926ggs+vAHd6OJ9mKqr3l1Bv9CP3hWMxAErTclBSbW8/0byttEAOS00mk0Cj/Iyr
         lgdw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfgOVKJKyzXuHSgkneI+7aRQj1SwFkAxLdpA4mGH51J/UNPtj+JggK5X+BAuOXoj+QDuGbq2RJU7qze9if1dJ/c7g7Qba123I
X-Gm-Message-State: AOJu0YxSbJ9A/loQQTu6qAMTY7CgWkJjOi7fjjncKZWGQazyrSCtyWeW
	ARgfXqTnf/TyXBGUMPjalRcaljUEvvyxrnO5AvJiB6UZeymGI6I7mJCDuUZZc7nLb7VUd8XFQ/9
	8S6n2H3JRKN5yXBK3Px8sFITVZMOArt9p
X-Google-Smtp-Source: AGHT+IHTMzC1x7n0TuL0MHWB42Pac36S9KhPSqTv+VQ7AB+vvq3TsBtpwG7nJP2fJ93y/ook9rGFzjabEn89BBX8Qrw=
X-Received: by 2002:a17:906:34d1:b0:a52:2e08:207e with SMTP id
 h17-20020a17090634d100b00a522e08207emr10433466ejb.77.1713351976478; Wed, 17
 Apr 2024 04:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417093026.79396-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240417093026.79396-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 14:05:39 +0300
Message-ID: <CAHp75Vebd-cp3D2sjBtZZ1vs2qA-ff3YgR2V84RgWmBcaFnNtQ@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Use devm_add_action_or_reset()
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use devm_add_action_or_reset() rather than manually cleaning up on the
> error path.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

