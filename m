Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D38DA220
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 01:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437662AbfJPX0C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 19:26:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39563 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406711AbfJPX0B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 19:26:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so151706pgn.6
        for <linux-spi@vger.kernel.org>; Wed, 16 Oct 2019 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=Qrvxi8VNIEP80MdoyXCLvX2dInmjYNYid6pa9CMx9/Y=;
        b=C1LD66Kn8oz6QcB4JFdprXZte3otJEvF9M2x3YmxrvIbQz6oHdj2oYpj6OogvYQljn
         rf6QL47fvOLb9HjbUEL+2zH59ECPYOgGXzagCFaZwp5GT1KcjTwrwM9pucVnjfhIlqBD
         ciUxzWRdllOfvxfpCZ3JK+oraf4kD0CEdfFdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=Qrvxi8VNIEP80MdoyXCLvX2dInmjYNYid6pa9CMx9/Y=;
        b=lsbE4Ag4AwKA25InIghncRdJkc2QGz7SjUWBU8eKhkIKJH9xZtlz7M5BTPPBJ2JFKx
         h4wXNfK7/Cz8ypN/gp58IBd/nBc0pk+Nf92SqlA/1WaflSojsG5CqoyjXWjP3cWIRyfj
         ljtKxl15ybZ4QLhqGLrosXcvOV9UHmr+v7tLGky4Z7nYAzujqIt70dFHOs1QE5nD9ZdU
         DPoJaTGFLMUCBYXXmWqlRjVmpXFKh4s68cTBCbSWHcFgWWQyJWgzpdAamSf4v5w2t4Ur
         rKnpqznBuNKF5wgc7KYsY0Em3G/Sq9yyndf+osy8HplhK3ZPY5WzokZ5quVzGW7ugedQ
         GKaA==
X-Gm-Message-State: APjAAAX7TRFlyDi5BmCKm3C7UMgSILAyMWBqBmEh4wHLmLtlFddWkQOj
        lbSjh9nDWeRMMqq9HcT5C0g/2Q==
X-Google-Smtp-Source: APXvYqzwan96igiVoJXoXnp0dlhIkgKisPOSNOslthiLl2WjZnd3MQpnyD29PbzVpemNzqdv3BAF4A==
X-Received: by 2002:a65:644c:: with SMTP id s12mr708041pgv.319.1571268358755;
        Wed, 16 Oct 2019 16:25:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y6sm182241pfp.82.2019.10.16.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:25:58 -0700 (PDT)
Message-ID: <5da7a706.1c69fb81.7818.0cfe@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016143101.28738-1-geert+renesas@glider.be>
References: <20191016143101.28738-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] spi: rspi: Use platform_get_irq_byname_optional() for optional irqs
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:25:57 -0700
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-16 07:31:01)
> As platform_get_irq_byname() now prints an error when the interrupt
> does not exist, scary warnings may be printed for optional interrupts:
>=20
>     renesas_spi e6b10000.spi: IRQ rx not found
>     renesas_spi e6b10000.spi: IRQ mux not found
>=20
> Fix this by calling platform_get_irq_byname_optional() instead.
> Remove the no longer needed printing of platform_get_irq errors, as the
> remaining calls to platform_get_irq() and platform_get_irq_byname() take
> care of that.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

