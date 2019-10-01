Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D0C3EA0
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfJARcx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 13:32:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37848 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJARcw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 13:32:52 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so22005345iob.4;
        Tue, 01 Oct 2019 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ME9JERHhVrbe9bZKOQu8b1hgHngZbw7UvQiOYqhf3AE=;
        b=K4u9RUQTlRAzpP4lzQfqEmLquc9JpM8ygSmmaYvctHChiQieDW4heA1Z0Ur4HDWvIb
         fbZWY/NIzFubV9g6dDf0LUC2ScRvY1ZyiGr7c1aZUTGlr7ZLDSVh/z6mWHHMCsXhdOv6
         k+/evVW0UNKvTM9upXIQLF+Bb7eYUXOX0z9A800GhjXe7ihOgiiv8fl5pVVfydjKBLvl
         nsEM8toqBhnEN2jhh2vLdYYP7P4EAjn7TV24Fc0q2qiWOSW7sphMV0uZBphI0gyuE1AY
         7xUcJiVTrbNjThUXpR85oIekm59z42fPyrEEZKHMHJ1tx5SP6dRD75s/7toh5bgxkZoP
         qC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ME9JERHhVrbe9bZKOQu8b1hgHngZbw7UvQiOYqhf3AE=;
        b=MCyn8hIFTE6qZYNHCnIJZuhoTuwKinq/DUzRrpmrPnF+yr1eQs5r0uAhttqbrj/Sae
         4Fb+8cgG70bbxKiV7WbnNLdrjlg8dqdCD6ua5yJabWPUFOUIlOlKGd7NRDpDZe+TUboE
         XZE8/EY5hFGHGtkyQ0QXbFPAhpUugtYyMhh5/0X1cE6CiFTsZF2D9qIs9r4O7ujFnIsz
         XIyRyt9/DtvtEwXlUITKrJ5oqbuO5o48abdOMXQR+X+HNKnyRxedvDE5UbkOnYm0T0F+
         XANk6z6YutI2n7a/L9XIZ4QH5P/4iZ6o+btHvMWRlgrq9xB+bhwm4Cgiy09IYEOuKmaA
         D+6Q==
X-Gm-Message-State: APjAAAUuV6Glqwur4cXuiYq8bxyx1i60Fyx7xYgR+ks6s/bjpQOrBCAL
        QazVLoMr4E1tp3tsL+3xNEMX/AMrabgWUHCfCBM=
X-Google-Smtp-Source: APXvYqyYxMAY5xQEu8G8vVHN+ATd4tNlLzhw/LbXbd0+G/Y0WbtHvI9gQ28fXhdaQVTfcMo0yQSeNiuKOf21ktWtsTA=
X-Received: by 2002:a5d:8143:: with SMTP id f3mr22230939ioo.294.1569951171833;
 Tue, 01 Oct 2019 10:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190930205241.5483-1-navid.emamdoost@gmail.com> <6b55e753-5797-2bdc-fae6-f575a0ef8186@web.de>
In-Reply-To: <6b55e753-5797-2bdc-fae6-f575a0ef8186@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 1 Oct 2019 12:32:41 -0500
Message-ID: <CAEkB2ES3-gotqS9184izf0fKOigFaFUetBiqekmYJPBgPWbSBQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: gpio: prevent memory leak in spi_gpio_probe
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-spi@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Markus, thanks for your suggestions for improving the quality of
the patch. At the moment I prefer first get a confirmation from
contributors about the leak and then work on any possible improvements
for the patch.

Thanks,
Navid.

On Tue, Oct 1, 2019 at 4:11 AM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> > =E2=80=A6 In order to avoid leak spi_contriller_put must
> > be called in case of failure for devm_add_action_or_reset.
>
> How does this wording fit to the diff display that you would like
> to add the function call =E2=80=9Cspi_master_put(master)=E2=80=9D in
> one if branch?
>
>
> > Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called i=
n every error path")
>
> Is there a need to complete the corresponding exception handling
> at any more source code places?
>
> Regards,
> Markus



--=20
Navid.
