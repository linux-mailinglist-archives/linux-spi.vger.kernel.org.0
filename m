Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D969F383D13
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 21:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhEQTTj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 15:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhEQTTi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 17 May 2021 15:19:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04C9E610CD;
        Mon, 17 May 2021 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621279102;
        bh=HAKoW8K/5XrQq2g0wnbVbhYoAtUrGPLMrypMPpHIgYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KW9vmrjRXLUqh0HY98qVLCPD8mQkBwXRKFpUjJHXfNePjXOKF98Mv8aB8OKVdwwe4
         YRshmT9jUrrMfWBBFzIH75ognU2xr+eqSD/VXBRh4qAvWcIJzj9ML8dxdCkbtld4mU
         kg/0i82CdTjp7pKILzeTfIUhrmdg4AfERCfhgYlIzXtJeW2VHupfTPRpGvKBxGa8qM
         aDTuw7KrdnxvVy5nZDaW6h1gBCfoyD9temEkXYo+8YyqXoLC/yNSEw5u+yjTaGh4lB
         FVlJzGBWYZFFqlpS7sMdzxjGyK+O388jgaCpRIVYKzsDPZq/RNCpisZcyd0zHnoE3u
         DQFm3uv6rle4g==
Received: by mail-ed1-f44.google.com with SMTP id df21so8232165edb.3;
        Mon, 17 May 2021 12:18:21 -0700 (PDT)
X-Gm-Message-State: AOAM533R79XsLKBPGzPqc+qVqbdIYDKA5Ci4zowDkeetA4XCc9fn+H4P
        jUdZug8pe5A+pWvdcGR+ByOjHIkF2J/lkhRVnQ==
X-Google-Smtp-Source: ABdhPJz+6aWvjzH5PdK+QuiEHy8Gi0mQlL/xEEsxsNv6ghzQALuDWCDRqsPr6e9menX7UxjucT/5htQ8RPa24aidTYo=
X-Received: by 2002:a05:6402:100c:: with SMTP id c12mr1886379edu.165.1621279100579;
 Mon, 17 May 2021 12:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210517153946.9502-1-michael@walle.cc>
In-Reply-To: <20210517153946.9502-1-michael@walle.cc>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 May 2021 14:18:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJPJj-3e7CZ4UQ=8FbJ3naduHrfQ+TmHH4x+4MBeubuAQ@mail.gmail.com>
Message-ID: <CAL_JsqJPJj-3e7CZ4UQ=8FbJ3naduHrfQ+TmHH4x+4MBeubuAQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: spi-mux: rename flash node
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi <linux-spi@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 17, 2021 at 10:39 AM Michael Walle <michael@walle.cc> wrote:
>
> The recent conversion of the common MTD properties to YAML now mandates
> a particular node name for SPI flash devices.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/spi/spi-mux.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the quick fix.

Acked-by: Rob Herring <robh@kernel.org>
