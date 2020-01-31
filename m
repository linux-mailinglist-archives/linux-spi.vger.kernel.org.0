Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62414EE34
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgAaOMQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jan 2020 09:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbgAaOMQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jan 2020 09:12:16 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1162173E;
        Fri, 31 Jan 2020 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580479935;
        bh=HfWBjLNte2X3JVYpxGFX1H9fFWZJ4RTRPHrm2f6bk+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=omIVpZ1/ygOrpZeS9FcNJS03c6J3B/23chS3RgaTQC7LE5mAwJAhKBS2CY1W3QHYL
         ylpgnBA9aE07DXWkWqta/RqOHb5XY9KCeYJZZxq6PKHlJ+ntCRvKXTWcGDQjCBch/7
         TTDUY8SHr60FqhpRtaS8/v5zQYSLyY6ntm4GmylQ=
Received: by mail-qk1-f175.google.com with SMTP id h23so6677444qkh.0;
        Fri, 31 Jan 2020 06:12:15 -0800 (PST)
X-Gm-Message-State: APjAAAW8xI213AIFV7ec2OPxlktrZtfWV4gyWNTrKEn9oHyjF/dbeQHW
        +6YAwDzIsbTJaRwBgXEz5vCyIAuXWwhdTW5MYw==
X-Google-Smtp-Source: APXvYqzP0vBMKxSW2Fs0L9a6K7gjQMP7QKfy0dyd+4vzzIDPqbXCB5JOkUuGgXS5/WDRGFnvTwpg4lrfI5M0k4tTocY=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr10924573qkg.152.1580479934910;
 Fri, 31 Jan 2020 06:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz> <20200131023433.12133-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200131023433.12133-2-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 31 Jan 2020 08:12:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLO4DT1s-q_5n23pLJw7PgnVNC6W3aAwkLFB_QdtV721w@mail.gmail.com>
Message-ID: <CAL_JsqLO4DT1s-q_5n23pLJw7PgnVNC6W3aAwkLFB_QdtV721w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: Document binding for generic SPI multiplexer
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jan 30, 2020 at 8:34 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding documentation for the spi-mux driver. This allows a generic
> multiplexer to be used to provide access to multiple SPI devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v3:
>     - make dt_binding_check clean (properly this time)
>
>     Changes in v2:
>     - update license
>     - make dt_binding_check clean
>
>  .../devicetree/bindings/spi/spi-mux.yaml      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
