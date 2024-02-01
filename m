Return-Path: <linux-spi+bounces-967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A75C845A80
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E01F2A432
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C275D473;
	Thu,  1 Feb 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuvsZ/97"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09755F467
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798746; cv=none; b=eVax1QIeUZnerFZtqDXd34yWR7aaiOd3V0AcI0sNriVY5zBiWYUJE9872D4tacjoxpdBOSU64hA7M4KUddtXC8jI04l7pAky0dzCMF6WlgLRXOxSobJOcI8RWKsErFQr/jVfRl1Az0duHV6zZ2BFqkZkRrCJPQLHH0C9iYY0sXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798746; c=relaxed/simple;
	bh=B79uE/yMhIIiixMu35NwcOC/wJc/tHoP4ewX9UKy9is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvKmbwxuB4Xva9Wd4TPeLVtkGG4RIIkBaGSsZWMmboS8oKAgTdSH9pt7aM7PSeCUtvoNnttaokMLUcFUJy6SWlR1bq4PVROlNNR62t6vf8KDTRoHiyiwgKDUPPhb/3JaGv4Kz66oB4UwdIRfJ+X8EKFv1fEgM+UGZnhlbYwE7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuvsZ/97; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a363961b96aso130539066b.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 06:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706798743; x=1707403543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+6L7ozl9BNK9DxdOqS1DFfUZ9jcMdSPhOs1H/c28HM=;
        b=kuvsZ/97wnD4afpjZnaWUM4KFYVEgzTvHfgEYM0ajPLO6VGCVK1FmYYClAst5Z+aJc
         CAPVGaXNvvXSe4HqvvBi1QO1r8em+IC76pYLHyc+MQOq76QNu9CWT20So/mn02kDG+WD
         1JuKsy2d3hGNiMLqHulNIy2R+H3c928HGQtCe//V7QHyp1Q1vi8UxIj4LIaht4b6JFLc
         AjyhLNGy52QecjsndJ9U3H0i8oaK5VLGKwTiAosWGIjIEVRyGHmXfS/ZwOaU0ZkEQSGl
         QoTKZSS95BU/i+qBS4ZUrlUacPCNDa7NFa6NEWFyyRVH3jJ8lZwy4Vwp5mX1Gzm+z0Df
         ocgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798743; x=1707403543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+6L7ozl9BNK9DxdOqS1DFfUZ9jcMdSPhOs1H/c28HM=;
        b=DaNTLcFhaX7eBzpK//cceCULtPeYFy/GrUwbipATXBl7OPVkLCZ2yIIDONgvupktiW
         Gkbi51R+QsjGRBO1l6bKItiCoQz2HetBZ3XLRgXERshHJLTkdGvrhprKbCpySaAMafOT
         BEmmU/ZYCagf/gNtzr0Nin0sCpss/dh5LXiTG1cCe/25hxxaaWuleGHztFe0hZgeT6br
         FdFvJHYmnD6ZRD4r2wmu2j7TjqXervchN/YOeXe151JLLSm9+zUaeSe9amd6RM+ugYMp
         gJ/KvWoVWmoiPXJYcUy2SdjE9ooHs+dyxxXKTjMkb+BvDPWp/KqeEnshYTtv6X3po4xG
         0GhQ==
X-Gm-Message-State: AOJu0YxFwpdRFkKekSA5ojr72+CPbb4GCO2jfb7Ln18bTlNvnatjaiNJ
	tjC/jYpIBC5hkyYEnRWtw2WPxD1497B43YDE2D2LahjGuix0TeWtLcf890QW9FkNoeXU9VkWx5g
	vO+GLqrFthXs2WO6nCj0kyslZ6iQ=
X-Google-Smtp-Source: AGHT+IHt3BLw/ieMx4KFyAtGbBtLitHzw+lYpSqy+3HeIUIvVRqC1gNeeGN5QseilG9HxhuLi6pbwVnwgCixFEPKxIs=
X-Received: by 2002:a17:906:1350:b0:a35:ee95:ffe3 with SMTP id
 x16-20020a170906135000b00a35ee95ffe3mr4234380ejb.17.1706798742671; Thu, 01
 Feb 2024 06:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201104443.363786-1-ckeepax@opensource.cirrus.com> <CAHp75Vf0WdSDPj6jrFb-3LFrDsc5WxT6GjaAiVVSBrEi0S4Fow@mail.gmail.com>
In-Reply-To: <CAHp75Vf0WdSDPj6jrFb-3LFrDsc5WxT6GjaAiVVSBrEi0S4Fow@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Feb 2024 16:45:06 +0200
Message-ID: <CAHp75Ve5jyRbm8MS6WQzRUC-nzTB+V1=iK7j9Ns7qjpBS5UzEQ@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Clean up of firmware node
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:43=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 1, 2024 at 12:44=E2=80=AFPM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > As we get a child node in the of case, we should also clean up the

OF

> > references to this, add code for this.

...

> > +       if (is_of_node(fwnode))
> > +               fwnode =3D fwnode_get_named_child_node(fwnode, "spi");
> > +
> > +       device_set_node(&priv->ctlr->dev, fwnode);
> > +
> >         ret =3D devm_spi_register_controller(priv->dev, priv->ctlr);
> >         if (ret) {
> >                 dev_err(priv->dev, "Failed to register SPI controller: =
%d\n", ret);
> > +               goto of_node_err;
> >         }
> >
> > +       return 0;
> > +
> > +of_node_err:
> > +       if (is_of_node(fwnode))
> > +               fwnode_handle_put(fwnode);
>
> Wrong order. What we need is to wrap this by
> devm_add_action_or_reset(), perhaps even providing
> devm_fwnode_handle_get() for everyone.
>
> >         return ret;
> >  }

...

> > +static void cs42l43_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct cs42l43_spi *priv =3D dev_get_drvdata(&pdev->dev);
> > +
> > +       if (is_of_node(priv->ctlr->dev.fwnode))
> > +               fwnode_handle_put(priv->ctlr->dev.fwnode);
> > +}
>
> No need as per above. If you send a new patch series where you add
> that API, I'll review / ack it immediately.

Oh, just realised that this is not a simple fwnode_handle_get()...
So, we need to add an action then with devm_add_action(). No need for
a separate patch.

--=20
With Best Regards,
Andy Shevchenko

