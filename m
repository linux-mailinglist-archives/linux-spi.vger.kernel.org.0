Return-Path: <linux-spi+bounces-5911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E746F9E42A9
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE852169DCA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6121764F;
	Wed,  4 Dec 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcGJHurP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9607217646
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333173; cv=none; b=pXNXr9h68H+lEvEbt8UbyX7bdN85bJyOqLeZSVyrUv/x2mng37e5fKAwwsmDtdBqDUvEH1rL1ChP9US4WCWkOBzHFsAkoJKt3AvOvXnAzFXQIJ4vKc2YdR2mK3aeOsd8X5eO/nbys6y3MYGJFC8b/X6BcdxlrAoFkMhWcqctRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333173; c=relaxed/simple;
	bh=3XOKyfOtCe+byiVNEcWIU0XMb6iWf0YuG2kDOBxGSKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXXgJ1xB+u28CBjxCxLmsZpOflm6/4SyMbtHtWa+xZG8IwSbeeSsubKGWFdD7ZeY3Mwac6sKUtEEq4s1tt8v/47aOXf1oCf0qiCbladm4hkhHOSvAnlfs/9wef2t+m7rFPb5kM0rRUDqTR54rVifXQRhU0wQLSC9yPTLwItjXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcGJHurP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso49030e87.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2024 09:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733333168; x=1733937968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=mcGJHurPFhyWZrzxsqhe3WqxFJ6pLKqpNZR9oI+eEzSGuu+sDvSvgQMRio6kGjgH6a
         KZ4dF6e1XOqzPO6uGws0h5EMgOQFmNHFxT7lLtBkfc/xsdSL9zJ8Ek+o+/fRT1jHYEmS
         SaB8m20QSdJbwsZkI7de/iKUf5IZGfww3N6JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733333168; x=1733937968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcxUVGNwDSHYT0cP1lB+JvbULa6oEpjDSAOsUsCsW1c=;
        b=UP/Sz8uaHV9D9Zm2SZm3bNCnsGeqb+rhE2vWHxPUxQEHK4mUkTiLVlG857vuXNs2e2
         8eYi9COXlTvkzc9e/+5Xk9bDieo+uRi2J5EJUydUrdWSzFFevOZO/Yvha73+ZnMji0F7
         w21T4uK2giw3hRMkwR06PHxrifaUVLu6NJOWCJxAUJZCAgUWAHQUKx0Hmv/qvrg6JaZ+
         EdAme8F1O+c4ExwgjyfhBCc0URBlQrFEE9EEtHWiCxXVaKeGIKbhHbciqDnzmJCr1hAV
         JdbPy0RPpYmIJn53PBPzzZ344l92kI96TaxeYWAnozXR+PNUd65W4qZQ336ddbsv3Wzz
         T6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWdD3b+bSYZeaWpYjWwRy+asIK46QUOoF89OXSLl4GIeCeXsChCRgmiWK7iZkj6SUv8nwMvbT6GoGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxW70lBvbN++JpyHhpaT29q20myzqcLGV4/HiMK8aOP4L6ifN
	zXbcotvyqnUrJU4FuqKVO8KBbP7u72CdPPLK0OfqnO9P17Jy9gh7vQj7hY4XC3CUPB042lzw5Ue
	tFA==
X-Gm-Gg: ASbGncsjbZsYNeGf9Nn/KyZB8s+dJn4oQZVat03huVjTeKeWWWULlrOH7jI+kuQ/6rF
	3KnzJ0OgepHl2fIZncnJEti1PtGBS6irovJliiaaXTjce6AFgearjaTmDp6cdyU4c3XRPN2xCNB
	7C5HqzPH96LJEdLZGh4jvfKrQy89gEhITWRGQHuE9NwplMzFL3gggIDQXaF/YefHnQLgcC8wrM+
	oldF7+NWWtXr/smZnrOzZleE/w0DBBW0DOw077n2dJLNBPZlkMXjuTF8A8DXdbA0K7qBqY/i2OT
	if1279EdfTiuUz/uYA==
X-Google-Smtp-Source: AGHT+IFDdKkoIJGYr965HmPsfkykA6PcRgn+5OESfAGWmOgrv9Ytswn7uApk/uqDINtFKjGupV+yMQ==
X-Received: by 2002:ac2:521c:0:b0:53e:1ba2:ee19 with SMTP id 2adb3069b0e04-53e1ba2efc6mr1541536e87.20.1733333168570;
        Wed, 04 Dec 2024 09:26:08 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1c51fbcesm361181e87.79.2024.12.04.09.26.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 09:26:07 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso64916681fa.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2024 09:26:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPObnh94q3ajAKODaVV/hUFiFLbngtzhtmTMR+yr9ynVji5xG7GRQJtUXsWXllBJfS/FM9tzrbzKo=@vger.kernel.org
X-Received: by 2002:a2e:a108:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-30009c3f871mr30428561fa.16.1733333166812; Wed, 04 Dec 2024
 09:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com> <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
In-Reply-To: <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 09:25:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Message-ID: <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, =quic_msavaliy@quicinc.com, 
	quic_anupkulk@quicinc.com, Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> support SE(Serial Engine) firmware loading from the protocol driver and t=
o
> select the data transfer mode, either GPI DMA (Generic Packet Interface)
> or non-GPI mode (PIO/CPU DMA).
>
> I2C controller can operate in one of two modes based on the
> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
>
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yam=
l b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..a26f34fce1bb 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -66,6 +66,15 @@ properties:
>    required-opps:
>      maxItems: 1
>
> +  qcom,load-firmware:
> +    type: boolean
> +    description: Optional property to load SE (serial engine) Firmware f=
rom protocol driver.
> +
> +  qcom,xfer-mode:
> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA mo=
de respectively.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]

I'm a little confused about this. I'll admit I haven't fully analyzed
your patch with actual code in it, but in the past "CPU DMA" mode and
"FIFO" mode were compatible with each other and then it was up to the
driver to decide which of the two modes made sense in any given
situation. For instance, last I looked at the i2c driver it tried to
use DMA for large transfers and FIFO for small transfers. The SPI
driver also has some cases where it will use DMA mode and then
fallback to FIFO mode.

...so what exactly is the point of differentiating between "FIFO" and
"CPU DMA" mode here?

Then when it comes to "GSI DMA" mode, my understanding is that the
firmware for "GSI DMA" mode is always loaded by Trustzone because the
whole point is that the GSI mode arbitrates between multiple clients.
Presumably if the firmware already loaded the GSI firmware then the
code would just detect that case. ...so there shouldn't need to be any
reason to specify GSI mode here either, right?

-Doug

