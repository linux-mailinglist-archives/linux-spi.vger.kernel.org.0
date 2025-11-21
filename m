Return-Path: <linux-spi+bounces-11450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B702C78351
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B8A0538BB3
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D139338F56;
	Fri, 21 Nov 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5K1TTAF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028B331234
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717320; cv=none; b=pSEBv+qhYCqQzmxJM3/SFOdTosZ/yi+EGW3vzlIvzWTI8Ze3tYbWz4claD1DoksUKQBorXtZaU3QZSRCAjpRASfRfLLVes4Y76IQJHO9875yeK0fg2ho8UUb7Qmsx4FaFqTjLl35drjXfiJSEvMPMZe7lL0TSpzzKKCfcWrTOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717320; c=relaxed/simple;
	bh=tVpi4KRfjiWBMscTlH0jcjffaJeuhPgxmDymKm2VoQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HudXQGLE38aVU1Nf0VeY7fT5cvpcStmBEE/1kcBsCbxPXy/aM7rOSctpZJKxlOIAXU3UQvrfcu2kmQO8KRS/ccig1eYsFQ6B0ws9VwtNw62G/Fljb9fpy+dV7RLMHLsiNsN/a2/GeEPvPRi0R9vTvi1dzxgG52uXpXgnZMj9mCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5K1TTAF; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso2768203eec.1
        for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763717313; x=1764322113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVpi4KRfjiWBMscTlH0jcjffaJeuhPgxmDymKm2VoQw=;
        b=m5K1TTAFqZoyZf8svfXCMnNcYbYakZNn7rg7j2ap7QiDJLOZ8B+Sf1UWCVilN52WRJ
         zSm2Z7rny/eQt0+Q/Hm7PtuZPD61nsrZpGV0XhiSR0DL0fhc43n8+eGq7qUfwNgDcD89
         8lZRSC2qGVxmX/lmt60THu/HUH0vKbzyS+t7idlUB3EFlX/Cp+EQEoKjBQR8X8tA01kA
         wv/a0ZwTH5rHELTtsP1SwQxpkOGIc7bNz14p9vBWu89aegaWCtysOfFjiCzMXAMjWe9z
         gVGGMVcEqrLpmqLvNsybPxMt0kVoQsP/CdtWCCr85D3CP6BPVdQzSg6AJPFNLI5WIHNG
         q+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763717313; x=1764322113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVpi4KRfjiWBMscTlH0jcjffaJeuhPgxmDymKm2VoQw=;
        b=FWpatqXVo5p6t70VwqCTgUlSwvhCAuQYRqfOEa98x/SlSWybBTGOkR5alf5AN6cgE+
         j9H+0oqN6v+aBI7BmlD7xF11beB6ZfhqWd4jre8kXvDwq6ueECKZY6ARbNcnYY1ZSdJe
         bV2Q7Gez7jbS049TpOJFXNAbe8rypYRaTHbmB8kUiZ/+fFHe07P+ZyFe7MsTc9/CkbNU
         ScLgQFD5Dmzm9vaLVm4YTCiybNRkuVv35VbpMbGsdmROqNzqkJXiEOCilkcZ2GpCLQ6C
         oXtkJbpeOivqAoCcG/IbR7zSZodA5K3TA/JsvoK2DJCxfJEoUzAFWm5N5NyrxBJi8iM9
         SpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbrejR5OAz+clqJ/bhoX8z3kWTJv4sB6HI1rbokuRgMQPMSYUJisJ03RT3/h8dwLiIWd7UOc/d4js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnWkIZTOCLadpOw7EnYYf2M4X/jFFkxdgyDz2RlnTBVuRc/oh
	kT5k/AU9chWYYCrCN4wyW04svnV1XESyacZoEMQedS85BCcbnLelhS6gDf45KHTXYkUEv99SToU
	JqbOsECqUT+o94Zo8l8mAjIYlVzk2jN4=
X-Gm-Gg: ASbGncsngotYRtPCUwC3genv3DIapW8kL3BQwKHm+UjjoyHdYGnf2Rynu/bGHIy1K9N
	3yq75z0H+wjHO9d7mLPQY2LDYDcsx8/sd2wiqBi9GNuOfC999WqVSEvW+2VP6lLPlADka8BzK6W
	EOCsj2tXk82w6cL1E5gEtN8yreANAiSNj+2NNvPRhNJgMZ9cRaEjk3jb78Kac5rn7R6FFD/R4Ea
	ZFVA8e8vthzcB3pa1LTKZpDjApVRNTkClvH/5TQEf6cxOCYur/eSRmD90TTJ9HZx2V2c25c620d
	b1+HNLJOZaNSCiElAbGdXAHQkBwGUSRAy3/68LWlSnLHqiWs3Q7YKH1RNN5gMZl2pMHKKPXcYRi
	+rW140OJ7hg==
X-Google-Smtp-Source: AGHT+IENwKl0uRm0AtfXY5xBvJH2Yq97sqz3IFZgj0rwmGn72hcMnayFF+NHDjS09wLJLsAjZiLl83AxVJTK5qa6VOU=
X-Received: by 2002:a05:7022:6285:b0:11b:a8e3:847b with SMTP id
 a92af1059eb24-11c9c9363d0mr629231c88.5.1763717312963; Fri, 21 Nov 2025
 01:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117030355.1359081-1-carlos.song@nxp.com>
In-Reply-To: <20251117030355.1359081-1-carlos.song@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 21 Nov 2025 11:30:59 +0200
X-Gm-Features: AWmQ_bnpiXdnOIi4lx5r0cxLjLdNMoZvteBUNmZvqdAN1a5gmVjrKg7KONGHfzc
Message-ID: <CAEnQRZDwPxRLZDy0+s2og15=C0G6ZnNPUEstuFTn5JLSFajJaQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
To: carlos.song@nxp.com
Cc: Frank.Li@nxp.com, broonie@kernel.org, rongqianfeng@vivo.com, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:06=E2=80=AFAM <carlos.song@nxp.com> wrote:
>
> From: Carlos Song <carlos.song@nxp.com>
>
> 't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
> u8. Using min_t with typeof(watermark) forces both values to be cast to
> u8, which truncates len when it exceeds 255. For example, len =3D 4096
> becomes 0 after casting, resulting in an incorrect watermark value.
>
> Use a wider type in min_t to avoid truncation and ensure the correct
> minimum value is applied.
>
> Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

LGTM,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

