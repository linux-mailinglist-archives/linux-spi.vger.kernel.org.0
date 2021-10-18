Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D665E431F39
	for <lists+linux-spi@lfdr.de>; Mon, 18 Oct 2021 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhJRORu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 Oct 2021 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhJRORc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Oct 2021 10:17:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560FDC033E82;
        Mon, 18 Oct 2021 06:58:02 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso59125wme.1;
        Mon, 18 Oct 2021 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gmfdgk1KBwEw+jip0D/cZORe1mhCVma1JLoP3pnRO1E=;
        b=airSlPzPEhy8OjDPISz+E8PFQaxTRHnofa0yBIyJKrXJTTMeblKrGnqBxcoVxZaRyv
         mya7il1HuLsAZcQoAepY9P6Qb9JXtcmOnchEuxnHNVaGEJuV+zji4kOeWWdBjm4DL7Od
         QEgBcyfFDktTU7fHy5R+sW2IeXYkTFr0T+SX5Vt2fz6C57ZYXmi80R/DjQy6jVQv5Xin
         T0UJe8rva3lI9J8de1QgZTwu3WCHThgMdc48V6Kxu7kTJnbXbEgFSvm22iDxpOVvmtjI
         /m0TdI2svD2C531IZQ9ixsxf7G67zcz9MZn0+O3VJoPmg50i8rClbFLfn7uQdUDsCRWw
         nAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gmfdgk1KBwEw+jip0D/cZORe1mhCVma1JLoP3pnRO1E=;
        b=ul87atj5DI+BmvEkucpCWgq0o+7UZEw+/oXBZje7HikkAhr+BGFOxwG6/Y6po3hdG3
         RTqJr++VeKwKLb/5tefwV+LyzgayJ/WbHwcPK+chWPGED7Z2cxL9lSTLAZpSzis/pah6
         aX4tGVFgpznXWEs5HsziI4MoG115jLCk7druwZuU6CM2wZovEdNAq9FhrLdyBF2n2fxZ
         rm6vFOLu4c+37vxTn6fQY5bb0/+5DMSOgzlRLxYrVOpXHjkNq7bqxJs5AGl5FSqetM4v
         B4OJpKdcer4VuTXC8/3lLWhCDCey8bYSPbcUmk8qPxkLWm5hjF9hmiMIviKBPLK524lM
         AJag==
X-Gm-Message-State: AOAM530KSDboV1VkIUChHhJ7XWtj7OaOPVksV1UmA/cOcqK+IQ45saco
        YZxGAiLd9yvgdi8NmWuJKk4=
X-Google-Smtp-Source: ABdhPJyVJQZPgb+/HJBe4TVTCkre6KUXxLoXSLUBGWUKI25QBzF6BdI0n7exDTua0kn5VdPhiUQZpQ==
X-Received: by 2002:a1c:808e:: with SMTP id b136mr43991536wmd.178.1634565480911;
        Mon, 18 Oct 2021 06:58:00 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id e9sm12409688wme.37.2021.10.18.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 06:58:00 -0700 (PDT)
Date:   Mon, 18 Oct 2021 15:57:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra20: fix build with CONFIG_PM_SLEEP=n
Message-ID: <YW19Z4gF7UCECF1H@orome.fritz.box>
References: <20211013144538.2346533-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CsoytHH9WhaclONB"
Content-Disposition: inline
In-Reply-To: <20211013144538.2346533-1-arnd@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CsoytHH9WhaclONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 04:45:23PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There is another one of these warnings:
>=20
> drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resu=
me' defined but not used [-Werror=3Dunused-function]
>  1197 | static int tegra_slink_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Give it the same treatment as the other functions in this file.
>=20
> Fixes: efafec27c565 ("spi: Fix tegra20 build with CONFIG_PM=3Dn")
> Fixes: 2bab94090b01 ("spi: tegra20-slink: Declare runtime suspend and res=
ume functions conditionally")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/spi/spi-tegra20-slink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--CsoytHH9WhaclONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFtfWcACgkQ3SOs138+
s6H54w/+KFibTIp68qtY887YsBRoL+r4ojZYMgigAPsUx+1Zr+VODGSFVIBTCMjJ
hw5Li/0uOf/mgKEP64f6Q84RqbjKvgJqKXsnNoTU+b3XsZC94TyjUFoO0cGVLSp2
QHXx90aUYQAuGVIapEVGJc3qZJX5JOQ8P5+UJSifM8SjCJm2/IGlZhguetI9MQf1
VZywdlCpDf8yINSw1zEIytmGE9x4BwqqGrRSt/EBA2VfkReL0o7O+lYo+Dn29xbZ
T+pVqP3hKvLzDexGLM6Xe1Z3wFWln27SW6RFNFK8+SMMyJ4Ff4YU6pILxQR3GEtO
5Ynoz/Osj4BZ0qe8JOe2ujeC6ajjQ/mMBOTeEehr2yLeEurR0DB1+DZHNRsQ4kJW
Plx9+XcK7OP/GIb7pSYvS7DRzLjG+AaMpipwcCevIT0UfXQfRL1TQZyyNJ8y2feh
0rZ38CNd2lZWrI+bhhMJYNSyFaJJZjhECA1pXLXAVVz7JvThkjuFTNN8FEJiwWSo
5cbwwk4mxBwTCJxAqGzrlk0WgC7MJJDW6WuH+tmKCz5hYv8ulTEZ1HHlE7ZZAkhx
9IgbBErOhDspomCJYDFpJuUEPz3XUod/xzZQwaWgrtyCN0+7MNk/gfsrIeTBHo0b
qUBVSAfQSksWa4GjN8L389EoY7+r5DtDxDFCyP48y65vqp3ruIA=
=kVAR
-----END PGP SIGNATURE-----

--CsoytHH9WhaclONB--
