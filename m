Return-Path: <linux-spi+bounces-966-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF5E845A78
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43001F2A3B1
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734275D49A;
	Thu,  1 Feb 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erq+e+Po"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C55D473
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798623; cv=none; b=ZAmTjK8xRIXTg8TDQVGjODlT9IzxV/6A4Fz2GoI20IL23lrAhUGb5x5/6V/Y/VQfzg9/Tf+9cbM09qnv3lcuj7u1AnXgEfP6LOwPWT5SxwinhKcT/t0T2hnYiGY1jdg1MPZfZE/u+bmvYKfdAQzYKQks+2pQ6HXQ/o2kNeP5K9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798623; c=relaxed/simple;
	bh=lRR+hByoBWtnETnrTxCeF6/VZXExaJ6AHC39ayAQJWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbLgecx30dA5S0G2ZtEICp4iIiAAUWJFbJCcLLcdtdqURjsD5th2PqURJZ310EqwXicj/cdXPVRayRAHOrZa1xwSd27rmNZKo5ytQcS/4HGzjrYWPdOZfnMKuxJt1inih1OZB4pCYgZrN0WiXE/D9Nr/hFuWFCtj8ENIkLBuLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erq+e+Po; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a358ec50b7cso183685866b.0
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 06:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706798620; x=1707403420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypwXnK+b6n5Zc0TmZRwMQAelLGDS6gGidAY2oh9x+6g=;
        b=erq+e+PoRg0A7tr+xC20/PwxiT93W9i3mrIdJjVFXUq9GJcsiiEzQCjEFo5rlC7VhN
         w6vcvJuWmg5KdWmUjP7vBrEa8Jt00RvUH7rG21cuBcrTHbt/BvksVR5ypUXi/m0jYTJb
         nzAYTUTNnu15aKvcj+RrdaL69daiUXraZphjHa44O39+lwglChnpmSbejBSjPOfeQe9l
         uTyRRIhOJJ3seoiKpZZ4NcISB1fvSKpTu/DOVs/mN7ROiFrPkGMFXQ71x0i2ES6KOpbE
         +587/VMGl+2vgNDKk49Xrvs4W/QTeFe+rM2ANDnA9eV05JorCzvfnIbAmelIHJpWyTOf
         GpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798620; x=1707403420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypwXnK+b6n5Zc0TmZRwMQAelLGDS6gGidAY2oh9x+6g=;
        b=bZn+QGn4T8zmuw5B5c1VLfxcoBXRBzuhuvsTun+HRYt9TdJyf0ge1TvUvSbkQxLsEX
         qBlT32UaxQCGk1YhpYpgVVsQ3BWsyslhvFm/Ec4RJiKqtPoiRaKWGVE+7tu/WsEeokED
         6YH0jParDs1vSzoOdCMJzVr4/E6/RYl9qsb7ExO07EAdIGikVmnyvZEr3XOX5fAS8rV3
         gryIqmQpBAtaYeyYjnvczqmVpd3APNYVmqctqf7hB1iEn2V9Bb25j9MgEbb4Fs7Jfiu9
         bIqHk89hiZUE8y0KDrHbctNX0oIUXdpJCoLaIFEkXVb+edqILMo6VSD7oxMdoo/QsyPI
         hlmA==
X-Gm-Message-State: AOJu0Ywaj7gp1wVauh9FTRKJZjwAdMY7OzBcHjEJVuP5cg0L7r50uYZp
	+1+RRI++56oXU4SbxGD095wUo1+BZ1qQ6/EHHpT4GNxPCTEwAmkXU2+zPF73pN53MfgljzNxng9
	YwWXF/2b0SKcWrKTOSHfj75EbbkA=
X-Google-Smtp-Source: AGHT+IHFzyq8TQuAVcA2E3YJSUdNN4VNkx75VAGjb98hrLVFCAd27dRcmnt1AGamGPGPvPQ8KuL1+63WZtbRDcHl04E=
X-Received: by 2002:a17:906:4ad1:b0:a36:8498:b78e with SMTP id
 u17-20020a1709064ad100b00a368498b78emr3971794ejt.27.1706798619623; Thu, 01
 Feb 2024 06:43:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201104443.363786-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240201104443.363786-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2024 16:43:03 +0200
Message-ID: <CAHp75Vf0WdSDPj6jrFb-3LFrDsc5WxT6GjaAiVVSBrEi0S4Fow@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Clean up of firmware node
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:44=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> As we get a child node in the of case, we should also clean up the
> references to this, add code for this.

...

> +       if (is_of_node(fwnode))
> +               fwnode =3D fwnode_get_named_child_node(fwnode, "spi");
> +
> +       device_set_node(&priv->ctlr->dev, fwnode);
> +
>         ret =3D devm_spi_register_controller(priv->dev, priv->ctlr);
>         if (ret) {
>                 dev_err(priv->dev, "Failed to register SPI controller: %d=
\n", ret);
> +               goto of_node_err;
>         }
>
> +       return 0;
> +
> +of_node_err:
> +       if (is_of_node(fwnode))
> +               fwnode_handle_put(fwnode);

Wrong order. What we need is to wrap this by
devm_add_action_or_reset(), perhaps even providing
devm_fwnode_handle_get() for everyone.

>         return ret;
>  }

...

> +static void cs42l43_spi_remove(struct platform_device *pdev)
> +{
> +       struct cs42l43_spi *priv =3D dev_get_drvdata(&pdev->dev);
> +
> +       if (is_of_node(priv->ctlr->dev.fwnode))
> +               fwnode_handle_put(priv->ctlr->dev.fwnode);
> +}

No need as per above. If you send a new patch series where you add
that API, I'll review / ack it immediately.


--=20
With Best Regards,
Andy Shevchenko

