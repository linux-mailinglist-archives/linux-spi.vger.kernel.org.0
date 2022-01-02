Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D01482923
	for <lists+linux-spi@lfdr.de>; Sun,  2 Jan 2022 06:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiABFRI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Jan 2022 00:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiABFRI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Jan 2022 00:17:08 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A0C061574
        for <linux-spi@vger.kernel.org>; Sat,  1 Jan 2022 21:17:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o12so68433609lfk.1
        for <linux-spi@vger.kernel.org>; Sat, 01 Jan 2022 21:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OUJm1l1Lkz1YaEdfh/UEwDaTVMcLzVdwO6tOQfKl7o=;
        b=EhPaLrzIg6G1hnSZHwGOBFaFHxH4UcQg44k8y7RnCfMMJ26s5yYuh3KY+LGCoUO72S
         zJ6UWj/g3J+AduMZdZqDx9LQwmBSwgLNID7w37AIoSfThf/Id7LBJF1IqdhQF/4U8IRB
         YyxQq5z7zRdxF77bI6jV79EMMjbhK3HRul9oK57hQO+cDjpiN/zUwHELKzk9UcWHf7fx
         dncoZMGHqFNmmiLDT/ehp5122zyz/vLMKwkgXoUhuRhVC2B55nmx/oqyLkdIkRrmPKp5
         1k64Q55v8bTDmR+ZAnkBIWNQ5fi+1UCfb8LXztefaq7WGWOkRL0Q8P8TIPqxSD2AuWe4
         d1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OUJm1l1Lkz1YaEdfh/UEwDaTVMcLzVdwO6tOQfKl7o=;
        b=D9T0kNPxtj+R1CPz+WO4yk8IHS5doHQpjz7gobzLx1nYjk39vUuGQyGW4GN26WDMMQ
         /SIaiI3d5TVMImxKKRZJTG31DJP7/ZMu3pQ8GQgWWJq/A9dFSJCLQC5Ybw3T0IlJI++P
         a1WaN6VbN3zdgvJCNZn7egJfL51VBz7I3fbeoVjqW0dylSvq9hGICi7c6CZDIHKq2WS6
         PK6XimXb0mZRZ2axJic2txglIrYPW/KZn0Ir6hIw6atXAGyliMiiKOPtuxsXannhIg3u
         yn9qklVrvlpnqvbs7sH1+lGsYPtNGa2KQ5ADcBcaeNqwhv/MdcczZAyMrZoB8xu+CbFR
         GSQQ==
X-Gm-Message-State: AOAM532QBo33uU724Oz11Yj02VPepHsCbdOF1XxFUK/VHXNu+rb9ZHF/
        nIJejuIdYHVAM2lDiIJRzAsoqVjtGiOeZPOBEFx5LbjiuAI=
X-Google-Smtp-Source: ABdhPJx1AorkEc1HSDDatFay0OziPayU+K/x43xNs6lLbJwcnlEBOfMLwN9/X8ZQciCUI5gZ71NO+Ml7PdU9DJ0OS/g=
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr18954362lfu.508.1641100625527;
 Sat, 01 Jan 2022 21:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20211220121825.6446-1-tinghan.shen@mediatek.com> <20211220121825.6446-4-tinghan.shen@mediatek.com>
In-Reply-To: <20211220121825.6446-4-tinghan.shen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jan 2022 06:16:53 +0100
Message-ID: <CACRpkdaGui4ULm7E7Y7YFLZ1BXKfvKKqv4KC=eTMBDExJThPdA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: pinctrl: mt8195: add wrapping node of
 pin configurations
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, broonie@kernel.org,
        bgolaszewski@baylibre.com, sean.wang@mediatek.com,
        bayi.cheng@mediatek.com, gch981213@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 20, 2021 at 1:18 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:

> On mt8195, the pinctrl node has pinctrl groups to group pin
> configurations by users' need. In each pinctrl group, it has
> subnode(s) to list pins needed and pin configurations. By supporting
> multiple subnodes, we can configure different pin characteristics
> (driving/pull-up/pull-down/etc.) in a pinctrl group.
>
> Update pinctrl-mt8195.yaml to add subnode in pinctrl groups and an
> example to illustrate the usage.
>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

This patch applied.

Yours,
Linus Walleij
