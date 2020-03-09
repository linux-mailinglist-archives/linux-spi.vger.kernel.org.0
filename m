Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0786A17E734
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCISbg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:31:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43291 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCISbg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:31:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id dc19so13164492edb.10;
        Mon, 09 Mar 2020 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQBQVzvdlwXN9vrpi/RnrrU9UTxK/Wco2Vk/EQR1DlA=;
        b=bDvak1MfyWU3fu2fK4+sOjHaqNuqCfAYCEpo25Yi2xgrft9SZGtp08cJmXLZbOrJy+
         iEOi0R/4PFbcWcGj/Cc7q6WU1ZVkD8LeYIelydQo6f8cAPODVySFo6lHYrrmfAKWSrTU
         p/e8lZ+pAbI8NEbqOh93YU/rxVjNWfNp57gYjpOwhdydadgSmtv63qJ+69l/tBEDXy7C
         QZlAWp4HeFar4ApF99o2dogfNBm84gF9HRUMVAeDXtlpU/3IQmBdY+P1EWu6ardHp7jH
         LSNumM1ZyigqLFvANj4KFll2roG+Ve/eL4WlZ0qyrNVM+jvA8GpWPxeQu+h0x6FGoIuS
         mx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQBQVzvdlwXN9vrpi/RnrrU9UTxK/Wco2Vk/EQR1DlA=;
        b=JDTd+LOFUzf6fZDoLG5oOsVKzgbuY5S+5dN7D2UXiTCCBf6nXJKgGO9PCTtt4FFxDw
         +m0TvkzbO0lx+kSMZW6CRBPlnafLJuc58uIyi5JNzOPYbZyNGfbQXVsWOsIO2MUPO5J9
         qiOyR7JReTu3iLjFnaa3HD2ni/dGlleou0C0JooC6gMDLRB46+MbGlNokJKi82DcFGZO
         2WmvODvJtUaxoMbGCW/3AP/QK6M2BVm5m3MItJrqvA2TfdHs7HMxjz3wwbigfueh0kci
         AFYgRCs/B9B98r5C0nzdpwjvbc6KsHkggPUCwaPJeXW9YFcrSjIHwIuLe+URoKZyIBnF
         lfcg==
X-Gm-Message-State: ANhLgQ3dUvzKuNtiz7nVSNgNyEQKnP0lFbNiIE+yCGjBsn+FMu8UwS3k
        paFRfKDIdN9gEtEeVrxkUzqxclbQL63qYpJ9gXc=
X-Google-Smtp-Source: ADFU+vsvahqTTbRVTo+rXvRbRch6Hm9UF2s1HMnYN2jVbP5JOl8ilePH2rluLrl1BfWrHYZfM0DtuDcQZfZSp3ImGeM=
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr16031550ejj.184.1583778693969;
 Mon, 09 Mar 2020 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-3-olteanv@gmail.com>
 <d8e39e402328b962cdbc25316a27eac8@walle.cc> <CA+h21hp4vC1c00rCgZo_hwQz3cE4dLBHjcgTHvf-+fS9a9VfxQ@mail.gmail.com>
 <a709dc91aac9124ed37ac1e7fcb7e105@walle.cc>
In-Reply-To: <a709dc91aac9124ed37ac1e7fcb7e105@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 9 Mar 2020 20:31:22 +0200
Message-ID: <CA+h21hodaPyY54fwRFNhmksg+9ugVvW7hndMCCc=cBG39D7jdQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] spi: spi-fsl-dspi: Fix little endian access to PUSHR
 CMD and TXDATA
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 9 Mar 2020 at 20:19, Michael Walle <michael@walle.cc> wrote:
>

> Eg. is it big-endian or little-endian if there is no property at all?
>

I think it is "native endianness" in that case, i.e. big endian on big
endian CPU and little endian on little endian CPU.

Thanks,
-Vladimir
