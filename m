Return-Path: <linux-spi+bounces-4798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769F976AD2
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C4B2835D0
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC131A7248;
	Thu, 12 Sep 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrauZmwi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360F1A4E7E
	for <linux-spi@vger.kernel.org>; Thu, 12 Sep 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148343; cv=none; b=i6gJK8Lh+83yBQn60+CXe6bwmKaoNX8Vc58bvqRqVWXdvWLMK6+Y9vocfPw3Qhkf35Swf4Met3wWU22W+cjDVT6lifFqkqLf5vyzdQ5yxOy7+JKoqjZu+aYV8vjYcMqpnoO6vuvYP3ZVtsL0Hek7BA2HCwjOJoCI5sM+rdpsvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148343; c=relaxed/simple;
	bh=XXqWO2yT//ii9l3KRjQXPc8FLHim6ZQatV7xee+2n/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDUc94YPnpQqO7BUDnIqNQOmU73zVvmZztaThRkZhtjtkvcCPgyhlyGU7Sp3gcmEQ117aFfDj1Y5lwPzfhlD9Yi9JgsSgLNrt+RhxXrBVH/Ja9xj1wbz+5ejwYaM5mL3F2MHO3RohTSY47XAWJQsE90QQ9HgyUhDHAzBHKa1Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SrauZmwi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99fde9f1dso79821185a.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Sep 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726148340; x=1726753140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ROrVvxpUOVpCOqDUYbk+Dw5AAWa4u/uZvSb0nkfTT0=;
        b=SrauZmwimIXsbi3eSM+0Htgj+O0TweNiDPgjMgOPKwS1GHvzXLmQWJWXo3m0JJq14r
         qmN57o8UraMAK5/QiotM05uYDOXNWBj9gmSQB+WTZwG4AJ5FgkZRVEMEfe0OxA5kje2Y
         mUBy9KE3JXu79DrhaKeptjd7hFNAqAPpgF0Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148340; x=1726753140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ROrVvxpUOVpCOqDUYbk+Dw5AAWa4u/uZvSb0nkfTT0=;
        b=ne1dbGvJcuExaiXdIw0KkjvCYGzFpKCstdmqsNmpmYWCGBUQJuvY3Kkr4ayCn72rIP
         cDfg3kigpK4FlYaRpZATGWSZeRVdjc24ktebFDDQvAOLhTko2HcXNxoBVVIvYe8iqwZ4
         uAT4mTqsdW6c8EeVWq+03iFHI5Kri2bAUIl89DmQzZSxxpf7l0kPswPveQf3cthlh92d
         94CpFrni7NcrqNmlgpm5+2v9oCCXIG3vn8XmLhH987cREiUFy8+ILwscADu/eL0qdr/M
         aWeH7TQ+/biD+upZq8FlCIiuLkg9oRgMBfc74A6z9X5NJ2X2TkELmcxW+2TJV9RiJl8W
         bAsA==
X-Forwarded-Encrypted: i=1; AJvYcCUVW+4OVYcECDkLvywPMLmr3L8jQzwNU1qoI5jO+jzDQiFYddfmajbNvrz00xlBiAa5BrNYaasuPD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+GN4mWdCItspUvhAsrfryAom8dXiclIjIOSB1mhx9wklEg6/F
	2rA8H/HQ21cyDbtr0zzdyijBEN78v7etu1u8DEubNM8Zm0Of/maRNUuMHkTm8E/V+kxb6ESzFy0
	=
X-Google-Smtp-Source: AGHT+IGwfTon/NGfphdkiDBeMkz3zeUq+fwp6PqNAarXUg+WOtMpSMePM+Ckq3FtMyIJ4gSCszAgrg==
X-Received: by 2002:a05:620a:44cc:b0:79f:1873:5463 with SMTP id af79cd13be357-7a9e5ee7c9emr441444085a.6.1726148339995;
        Thu, 12 Sep 2024 06:38:59 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1da04sm540560585a.112.2024.09.12.06.38.59
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:38:59 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso6921876d6.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Sep 2024 06:38:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6ePhlB046MMLZdJipBPSzw+ebV6VP/rjPR9XaWbg0JPNzGAjr2Rirqj/aPqTzzisBlD4v3oMsJLk=@vger.kernel.org
X-Received: by 2002:a05:6214:2b97:b0:6c5:50ed:ac3d with SMTP id
 6a1803df08f44-6c57351b1ccmr42400066d6.16.1726148338348; Thu, 12 Sep 2024
 06:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com> <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
 <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
In-Reply-To: <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Sep 2024 06:38:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
Message-ID: <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, vkoul@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 11, 2024 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> >> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_devic=
e *pdev)
> >>         if (ret)
> >>                 return ret;
> >>
> >> +       ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_cha=
n, mas);
> >> +       if (ret) {
> >> +               dev_err(dev, "Unable to add action.\n");
> >> +               return ret;
> >> +       }
> >
> > Use dev_err_probe() to simplify.
> >
> > ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
> > if (ret)
> >   return dev_err_probe(dev, ret, "Unable to add action.\n");
>
> It seems that if it only return -ENOMEM or 0, using dev_err_probe() has
> not not much value for many community maintainers.

While I won't insist, it still has some value to use dev_err_probe()
as I talked about in commit 7065f92255bb ("driver core: Clarify that
dev_err_probe() is OK even w/out -EPROBE_DEFER").

-Doug

