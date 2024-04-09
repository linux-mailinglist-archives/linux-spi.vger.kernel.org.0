Return-Path: <linux-spi+bounces-2235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64F89D1D9
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 07:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FEE284705
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7E5F569;
	Tue,  9 Apr 2024 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMY5owiJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77571433C8
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639625; cv=none; b=JsqMfANZaOnonJZuWdtp1mdX2IyP+QJ4gGV/lVZlvhWq0PeIUZSg9lrFfkUMdhRZn/J+p2osMzL5K8KJyuLYaLpPK61cARbj5j4Re5kAvS1+NNRSGWqEc9iHk4WQDqaQnYUpuVRZS+3OpsPFtJlT45M1VGMh6E/L2prQSMiIzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639625; c=relaxed/simple;
	bh=KKjF/zFeP2l4ureM8YQ44jPQw1jLe60wvSyJYXpz6XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K73TwtDy80//WVYgemW2LkeKD/dzSBXlkC5lenzS6DbgUUrPbgUYa7gAuSw2ZJPR94yjGHkfF2nTvcC6NjyxgDZJsqtlOg4g6D/FQc0BB8dbO1IR4T4LUz1mELaSBHB1OgfHeqBUVl4xEOmbKUV9KA2fY8aL78T9+CCmALo3yE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMY5owiJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43477091797so118931cf.1
        for <linux-spi@vger.kernel.org>; Mon, 08 Apr 2024 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712639621; x=1713244421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6G7fQwZrU8Ut2ONWgYwB5iUHvGBDAPNe+jjAW2C4Mg=;
        b=LMY5owiJ6d9Q1+QuH1YFu5x2LaD9Xn3ti4Co230Nr4lYHpug/9VfXK5Qf8ZDZ3vC6b
         8QfihJ4GQ+3F2YhI96evxjnqqlAeyqdbzRnaORale5loyceoqlk/koG0UqPQMaZwRkgm
         EhjLw26k1QwwBywkgIk7ZyQDOncs/gECAdnck2xs63NQNF+VdE/Z7+2aSkMChp9S54KU
         pL/yG+j0V7oo5ikfBjNZ5RZErJo7VDbwvOya90y6SpoyaxYWXvo44C12sKnZmNpMlUNh
         5Kd2U/nTpf/2c9oEPXcWIlJsdSOW7uQR5SWjU3IJLbYt95XLJ7Dyjm4FTT2/zo4w1PWQ
         SRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712639621; x=1713244421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6G7fQwZrU8Ut2ONWgYwB5iUHvGBDAPNe+jjAW2C4Mg=;
        b=FNXuebTz/9n7goZljK0J3Xev80Mgvs+WQ703DgWi9dmUM1cEuh7qw9TqGeMiI4r8HI
         pVvX0ppRd5iymYB/SpJSSdSpS6mC4DDLxG4rrNFtrnrFGXb/fg5E6nfSJ/OsoFjjVSsR
         NVtgXtzaMtJrz3XUuR2ZFIYCjN7/QkZzCVZncLDwxHwr3NuHfKKmhizi9j9TYyNAQWf5
         UZPyfyD94qkf8ORtiskTXzYW+aPzSmpiKBED8mPExgHEKoxl8BufDZEa5+NhKCRzNgjT
         7i43au4g2P/j1QrS4YRGOc3w0ovuHfSmEOYtBybDHoKpHwa+pB9ugrXRS6ee47aNGPPf
         qnDA==
X-Forwarded-Encrypted: i=1; AJvYcCXvbXGWLl7QFowP1lWcwLkoaTCazdGP+knRjoSZh3vgQshm2kDowxmzc+ITM1nfdkOCO5bhgH+AGH4Huo/1XpilSeEQASA1sWrH
X-Gm-Message-State: AOJu0YwOEG2bCFR1g7TkfqI8CrdbakFtZUqdrqeDALioJ0l3NpdFKBUs
	7Y5wrEU9HCiO7NYA+46iCbHG8ROWiDJbv/iCABkjru3gBvfvjAvFofLhTXa1DrT/MNbFh9VaE6I
	x1dJUB9fCkYJm8V3Sf0YmeAM9fQgYQ7DyNKGL
X-Google-Smtp-Source: AGHT+IGtzSNJgjDc/nC7nFe1GhF37b1NuM2JGv6SOuE597isSLhoxrccb1PNcX9sCRP+cNte/jpd8sOR+EPxlmcj0Y8=
X-Received: by 2002:a05:622a:1f9b:b0:431:6155:c602 with SMTP id
 cb27-20020a05622a1f9b00b004316155c602mr124400qtb.3.1712639621316; Mon, 08 Apr
 2024 22:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231310.325451-1-saravanak@google.com> <20240408231310.325451-3-saravanak@google.com>
 <CAGETcx8gGcq01CwTZyn=Q0fSQkzMf6tshSmPr5YWYZuhhJVdXg@mail.gmail.com>
In-Reply-To: <CAGETcx8gGcq01CwTZyn=Q0fSQkzMf6tshSmPr5YWYZuhhJVdXg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Apr 2024 22:13:01 -0700
Message-ID: <CAGETcx8j50dpovO-Mj0MjpYcw+n6T9ei6mo8tm7BVkcjfy_VVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] of: dynamic: Fix probing of overlay devices
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:40=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Mon, Apr 8, 2024 at 4:13=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > Get fw_devlink to work well with overlay devices.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 10 ++++++++++
> >  drivers/of/dynamic.c   |  8 ++++++++
> >  include/linux/fwnode.h |  2 ++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 5f4e03336e68..d856f9c5d601 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -237,6 +237,16 @@ static void __fw_devlink_pickup_dangling_consumers=
(struct fwnode_handle *fwnode,
> >                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
> >  }
> >
> > +
> > +void fw_devlink_pickup_dangling_consumers(struct fwnode_handle *child,
> > +                                                struct fwnode_handle *=
parent)
> > +{
> > +       mutex_lock(&fwnode_link_lock);
> > +       __fw_devlink_pickup_dangling_consumers(child, parent);
> > +       __fw_devlink_link_to_consumers(parent->dev);
> > +       mutex_unlock(&fwnode_link_lock);
> > +}
> > +
> >  static DEFINE_MUTEX(device_links_lock);
> >  DEFINE_STATIC_SRCU(device_links_srcu);
> >
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 19a1a38554f2..0a936f46820e 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -237,6 +237,7 @@ static void __of_attach_node(struct device_node *np=
)
> >  int of_attach_node(struct device_node *np)
> >  {
> >         struct of_reconfig_data rd;
> > +       struct fwnode_handle *fwnode, *parent;
> >
> >         memset(&rd, 0, sizeof(rd));
> >         rd.dn =3D np;
> > @@ -246,6 +247,13 @@ int of_attach_node(struct device_node *np)
> >         mutex_unlock(&of_mutex);
> >
> >         of_reconfig_notify(OF_RECONFIG_ATTACH_NODE, &rd);
> > +       fwnode =3D of_fwnode_handle(np);
> > +       fwnode_for_each_parent_node(fwnode, parent)
> > +               if (parent->dev) {
> > +                       fw_devlink_pickup_dangling_consumers(fwnode, pa=
rent);
> > +                       fwnode_handle_put(parent);
> > +                       break;
> > +               }
>
> I'm clearly calling this in the wrong location. Please move this logic
> to __of_changeset_entry_notify() and for the case
> OF_RECONFIG_ATTACH_NODE. Haven't fully thought through the DETACH
> case, but it should work correctly for that case too. If not, I'll
> take care of that next.
>

I'll send out a RFC v2 with the code fixed up in a few minutes.

> -Saravana
>
> >
> >         return 0;
> >  }
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 0d79070c5a70..4b3f697a90e8 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -220,6 +220,8 @@ int fwnode_link_add(struct fwnode_handle *con, stru=
ct fwnode_handle *sup,
> >                     u8 flags);
> >  void fwnode_links_purge(struct fwnode_handle *fwnode);
> >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> > +void fw_devlink_pickup_dangling_consumers(struct fwnode_handle *child,
> > +                                         struct fwnode_handle *parent)=
;
> >  bool fw_devlink_is_strict(void);
> >
> >  #endif
> > --
> > 2.44.0.478.gd926399ef9-goog
> >

