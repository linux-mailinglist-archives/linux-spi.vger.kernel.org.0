Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4283C72CC
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhGMPLD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 11:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236842AbhGMPLC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 11:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 806B96128C;
        Tue, 13 Jul 2021 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626188892;
        bh=KQT9Z7YvdNmZBh89mDjGFdmNP8HcF0vPgCUlUtMtO2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScxjE7H5N+kVpb24NJU63pQmaWeACZZBfks1bx8BuONJRYyPvRjsGlB/jd1H/EkAl
         VGS9K0Owgm+DDKGMrB+VIESptkq1BVBSDkcUBh0DktLvTX6q+8Q4eioQkWQy0tYqal
         S7oTxCgra71qXsW9uUWU5ARrw5t+kBlYig/jqV2Gfd55wA2T5n3Z3L/668pDdfto2u
         R/Q+1CI2wsRUgEMrb1T7WOEWD2HDYbxn7myEDoSWQmFKi1CwQu0A46ky2XgIYeTAXo
         t8m746YdWk6AQquc/CzD60fRaq0+mc74tQzEZ2oUGA651EQkInPcJRKljjsG6+eWNN
         60QqKDl24sOkQ==
Received: by mail-ej1-f46.google.com with SMTP id ga14so27092121ejc.6;
        Tue, 13 Jul 2021 08:08:12 -0700 (PDT)
X-Gm-Message-State: AOAM533XFjXVmNGyZVDhQnh9DakcwxxgWaLpNhQHXfG+iugl1qDAYAF8
        jhBq3x8ZQHW8zu/oPhfAV2SVcLN7jAc3630wSA==
X-Google-Smtp-Source: ABdhPJw0Fw8R0C28MNb/35eTmgMsYLTieB81Bgmf7Xw5IEUhfkDZhHhFuE2ymY7Si9cBaq9rTITzvM87u6UeMl1LOAk=
X-Received: by 2002:a17:907:9720:: with SMTP id jg32mr6142376ejc.108.1626188891073;
 Tue, 13 Jul 2021 08:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210712150242.146545-1-sebastian.reichel@collabora.com>
 <20210712150242.146545-2-sebastian.reichel@collabora.com> <1626184993.653258.129709.nullmailer@robh.at.kernel.org>
In-Reply-To: <1626184993.653258.129709.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Jul 2021 09:07:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK2v9W=+GLEpAUFWeD4P3uiq2i7CWkwP9t76+e6dTtQ8A@mail.gmail.com>
Message-ID: <CAL_JsqK2v9W=+GLEpAUFWeD4P3uiq2i7CWkwP9t76+e6dTtQ8A@mail.gmail.com>
Subject: Re: [PATCHv6 1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Ray <ian.ray@ge.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 13, 2021 at 8:03 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 12 Jul 2021 17:02:40 +0200, Sebastian Reichel wrote:
> > Convert the binding to DT schema format. Also update the binding
> > to fix shortcomings
> >
> >  * Add "nxp,kinetis-k20" fallback compatible
> >  * add programming SPI interface and reset GPIO
> >  * add main clock
> >  * add voltage supplies
> >  * drop spi-max-frequency from required properties,
> >    driver will setup max. frequency
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/misc/ge-achc.txt      | 26 --------
> >  .../devicetree/bindings/misc/ge-achc.yaml     | 65 +++++++++++++++++++
> >  2 files changed, 65 insertions(+), 26 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
> >  create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml: spi: spi@1:reg: [[1], [0]] is too long
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml: spi: spi@1:reg: Additional items are not allowed ([0] was unexpected)
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml

Ignore this. The necessary change is in v5.14-rc1.

Rob
