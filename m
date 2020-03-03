Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B293F178489
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgCCVFZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 16:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbgCCVFY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Mar 2020 16:05:24 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D7B2146E;
        Tue,  3 Mar 2020 21:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583269524;
        bh=l0YEzEcw/Z/MYavxZmPE44wKNAPCOgQiZ1klzLxOAEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bu7CXHIxoexZXi91bDRNmminmj11m9NGuJWAUh6fJPiEIyhr3NrgwT0n9WgjdPl0K
         XA83YUpc/J0wtR0XKC34qXEyN9RAtKaLFmCqlNKnRV7RBbJPBo9e6YReXQaKqbRaok
         0bZVTsVciEc9A2mq6KtPt7e2s3i4LF8bn0pZ13TM=
Received: by mail-qt1-f181.google.com with SMTP id j23so3975663qtr.11;
        Tue, 03 Mar 2020 13:05:24 -0800 (PST)
X-Gm-Message-State: ANhLgQ33YFuaY+EZmQ/dYZFbAx9DlI9T7ynCMsfLn1gS62jxVxzeT2NE
        80g/jpMJyIPcquJB/VinMZ+ZiGEspKb3oV4OSA==
X-Google-Smtp-Source: ADFU+vviKc+PiHIAnxb4cNOMK3iEsnPkdMlcEhwKIVwZqSFfJWBHvRreL4SqLdVlJWVtxMojJWLWnBDtd51l9VcKzWA=
X-Received: by 2002:aed:2344:: with SMTP id i4mr6376332qtc.136.1583269523329;
 Tue, 03 Mar 2020 13:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20200303094522.23180-1-geert+renesas@glider.be> <20200303094522.23180-2-geert+renesas@glider.be>
In-Reply-To: <20200303094522.23180-2-geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Mar 2020 15:05:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
Message-ID: <CAL_JsqL+9Tcqm_bsorRwqvWZyJXAZmJhXb=EmJ+nZ44kCFp6Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: spi-controller: Fix
 #address-cells for slave mode
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 3, 2020 at 3:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Currently, the DT bindings for an SPI controller specify that
> "#address-cells" must be fixed to one.  However, that applies to an SPI
> controller in master mode only.  When running in SPI slave mode,
> "#address-cells" should be zero.
>
> Fix this making the value of "#address-cells" dependent on the presence
> of "spi-slave".
>
> Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Use "enum: [0, 1]" instead of min/max limit,
>   - use "- spi-slave" instead of "[ spi-slave ]".
>
> As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
>
> However, when using "#address-cells = <0>" with W=1:
>
>     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

What was the point in having #address-cells in the first place for
slaves? Seems like we should make it mutually exclusive with
'spi-slave'.

Rob
