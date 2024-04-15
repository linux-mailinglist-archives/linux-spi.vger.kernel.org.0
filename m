Return-Path: <linux-spi+bounces-2351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F48A5782
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E69289B8A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Apr 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E6745FA;
	Mon, 15 Apr 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QetZo5Az"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6953762E0;
	Mon, 15 Apr 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197875; cv=none; b=hTNWiU/FPMzx6BIAE5rK6iWxm6iCOFzFODAYRST2Gj5yPaqU2mB+rtrgaE1B/DRkRlhauu9Wl/n5YWHTgKUBR56IAFSCC8NYRW/og3ZXK0LIxCRanYiK2zVFZlmwPVuo86D73mlaA7ue0kXF4YTjIZDCnawJdbjg7V9XSJ6ZQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197875; c=relaxed/simple;
	bh=Fq4by5OC7xJIGUIl4k7CVsliccMI6r5FNIq25fsIe60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP4scD6gPYGQc9Db03juzUSBvCEgFwl+R1sxiJLKws1EBDq95w3BhtkCNHnYTFaTcnyJ7rQCPDkpvf/0W4YfSaQv6X+j3i0MtHRNgt4LQYLBOEB6SnZo3dADb8ofNwoWJnGYtiKXVeqUf+kF28u9wAxtsa6wM6Woo1vf8qWo5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QetZo5Az; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso3944074a12.3;
        Mon, 15 Apr 2024 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197872; x=1713802672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5OEogp06Qli360hKf7kAHGwHqUNVUtYIaLE23KVaFo=;
        b=QetZo5AzrpDqKb3iQYK00a0xbGNr4ybnxJUal+3qLnuGSSxzdJBdkHiAIMAkWlwQ8o
         UpsbvNiKRlP0+YwnN9XMFFxSbSuml9B0yJIoVD4guXus+uuwF9Hfl6IT7PXvZhvWGR0o
         ma20CEqF5y6Bg7zKyrPGjcX5KEyiGr1zj8/CuGBZM9EfN6E+7yQWGSdXgL8guL8xe/TI
         E4EfXasKIi4ps8JEziQwAA0Z+M8MV+nT9ti71w6QqUoLzLuECS8R2ifkjOYn/oq3nmsL
         LxnLB9MaxCn+HGmsGEtR9+iqPeDbebsWIH7sszZ2T+SebiZrIL5DNOziHs9VyY6yGAld
         nStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197872; x=1713802672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5OEogp06Qli360hKf7kAHGwHqUNVUtYIaLE23KVaFo=;
        b=waK4uJ5DI70aBwFEm48BEuFloz5N1kpgClaMPQ0VlnRN/C+GxjTDAZe43XuKAphncO
         UwuvyH+5kqwlf1NaPviD5eDYyPPDHFaHO8SbuZmTix3IjWIEqwvGscvaUbsSetRg6y+m
         CegoJzHoWhuee9SOIBRf5lPOz7IpjsWYrKArt4zNjUlwIjTMMiEL5o+UmE9wqIFsr7iJ
         7g2x9BUBmjpzgRtOOo7O3N/3e6apE5LPx956FOkIzHIQzs4c5jx2BdmFzqNp02BPs13G
         WAa9CEAtbxWVIhMnC4Kb3vwziLAum3YlDcZQmN5Szq03+CopndgQzlxVMUnQ0kw0KEot
         3rTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdUqBuC/lCZS07gf/cOGWdZ43aLCnuJL8axNC2594RsWDdYSfBde9RIDwcSentbVxP6XGHPgWOtc/Lq8Qs2l1wZCJ+lCGjSjnQ2+Sp+cScTf2mjZBrp5ko+murzJJBWQioOZ9M+Q==
X-Gm-Message-State: AOJu0YwZDjWLrMwRuyITIVNVExLEpZ8qd26F6UfPmGZmsSYh1KV0PGBF
	NIMfIjwta8S9OsEpFn0wivMUovFa6rveiCw8Lm9M1lMxAM2QWOaw4YsNfnb4nge06npAuNViaO9
	bN+PjA0XOEtMmfvJ6VzRESyryCTMn8//n
X-Google-Smtp-Source: AGHT+IHay95yHcrLkCIZCruE6Hb2ex0LRmOM9jp7Ow69x8TlMilEixPEQwM7TbZsrUKMgRv5SxhKUvYh08uatASgqhg=
X-Received: by 2002:a17:906:15c7:b0:a51:9421:8273 with SMTP id
 l7-20020a17090615c700b00a5194218273mr5911842ejd.62.1713197871909; Mon, 15 Apr
 2024 09:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415140925.3518990-1-ckeepax@opensource.cirrus.com> <20240415140925.3518990-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240415140925.3518990-5-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 19:17:16 +0300
Message-ID: <CAHp75Vf-n=crCpRnKQ-030czDJFJmp6J+QStiehYwdMwGM+zog@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:09=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
>
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually.
>
> Check for the presence of the "01fa-cirrus-sidecar-instances" property
> in the SDCA extension unit's ACPI properties to confirm the presence
> of these two amplifiers and if they exist add them manually onto the
> SPI bus.

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
with the caveats:
- assuming primary - secondary fwnode expectations are correct
- no support for more than expected (2?) amplifiers as per global
naming of swnodes

See also the comment below.

...

> +       if (has_sidecar) {
> +               ret =3D software_node_register(&cs42l43_gpiochip_swnode);
> +               if (ret) {
> +                       return dev_err_probe(priv->dev, ret,
> +                                            "Failed to register gpio swn=
ode\n");
> +               }
> +
> +               ret =3D device_create_managed_software_node(&priv->ctlr->=
dev,
> +                                                         cs42l43_cs_prop=
s, NULL);
> +               if (ret) {
> +                       dev_err_probe(priv->dev, ret, "Failed to add swno=
de\n");
> +                       goto err;
> +               }
> +       } else {
> +               device_set_node(&priv->ctlr->dev, fwnode);
> +       }
>
>         ret =3D devm_spi_register_controller(priv->dev, priv->ctlr);

Left this chunk for the context below.

>         if (ret) {
> -               dev_err(priv->dev, "Failed to register SPI controller: %d=
\n", ret);
> +               dev_err_probe(priv->dev, ret, "Failed to register SPI con=
troller\n");
> +               goto err;
> +       }
> +
> +       if (has_sidecar) {
> +               if (!spi_new_device(priv->ctlr, &ampl_info)) {
> +                       ret =3D dev_err_probe(priv->dev, -ENODEV,
> +                                           "Failed to create left amp sl=
ave\n");
> +                       goto err;
> +               }
> +
> +               if (!spi_new_device(priv->ctlr, &ampr_info)) {
> +                       ret =3D dev_err_probe(priv->dev, -ENODEV,
> +                                           "Failed to create right amp s=
lave\n");
> +                       goto err;
> +               }
>         }
>
> +       return 0;

...

> +err:
> +       if (has_sidecar)
> +               software_node_unregister(&cs42l43_gpiochip_swnode);
> +
>         return ret;

This is wrong in terms of ordering.

...

> +static int cs42l43_spi_remove(struct platform_device *pdev)
> +{
> +       struct cs42l43 *cs42l43 =3D dev_get_drvdata(pdev->dev.parent);
> +       struct fwnode_handle *fwnode =3D dev_fwnode(cs42l43->dev);
> +       bool has_sidecar =3D cs42l43_has_sidecar(fwnode);
> +
> +       if (has_sidecar)
> +               software_node_unregister(&cs42l43_gpiochip_swnode);
> +
> +       return 0;

As this one.

> +};

You will remove the software node before removing the controller, this
seems incorrect ordering to me. What you need is to wrap by
devm_add_action_or_reset() and it won't be any remove() callback
needed.

--=20
With Best Regards,
Andy Shevchenko

