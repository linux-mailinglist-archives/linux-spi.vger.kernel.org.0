Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD5589A0D
	for <lists+linux-spi@lfdr.de>; Thu,  4 Aug 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbiHDJnT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Aug 2022 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiHDJnO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Aug 2022 05:43:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AD067C80
        for <linux-spi@vger.kernel.org>; Thu,  4 Aug 2022 02:43:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b96so14280542edf.0
        for <linux-spi@vger.kernel.org>; Thu, 04 Aug 2022 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r46KFAl4TfFrC5l4SGRajq+tNuzO0BzQHbXD1x0Z/2w=;
        b=S6+kVL8ePQUIYSD3wWZf+6Pbn/YJcO8W1A3nf+MjPxiPTw1s3u49W3+ELbyG6s/xl7
         c+yoWpfXqGIP5xtVPCeYjZVKiKbnre0b1aTWbTRKJq4WUY/OGH8D6jNg805M3ZiIE+2J
         i7dNgji2dSjRo21/WVTamuNS2A/Iaquww5t1XJ1aME458WiKttystKbGaEvWGEBR1drW
         RLh7a0RPsL8OihN6VhlR5QwGOQEDuOSXxeVLX906Bewb8hDX/ANliqvPOuaB8sCVaceZ
         UV76VYf/UNl84XpUjtvHOITS2tE2zQzBMMuxmEwZONFwxaXoMF8SZWRp7WulkBrtI92F
         hh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r46KFAl4TfFrC5l4SGRajq+tNuzO0BzQHbXD1x0Z/2w=;
        b=j/JofTtXAnlS5w090bWMucumaGiBmS/ZO6QStHpKL7fGXZzfE8cHpcys0wY+uilAJE
         XX6PBgay50FYpF8JjMhwow1JvvLod5OeEGFOwykIpnGraVXqtdtARSjg6HuUKEhYV9JX
         g99iXs6x9cLEuwn6wO4zsWluK6qp6LhDEu/IWiIWzEHQkSaVvdSZSSoZcTWpkmvO/6Zs
         PGft46D9IJq2ryel2X4bY2gUO3XAUUTSFgDqiP7BQQLrEP9k7P0PM36iOw7U/g2oJkIM
         yhOzAUa0OxKk1iDFpyhQJd4sr5gfoPBaIzIVyUSgOPNezNtqyprl6iaZbcCXryBl5iHj
         iUUw==
X-Gm-Message-State: ACgBeo0JWRd37gao/9dyVMYmfdmnmPXrLPQhZVVVOVeDtXr044W8iIVF
        UUzMQG1/P50H+31/X4XvLEoVTQBFi0OI55bkHliHdQ==
X-Google-Smtp-Source: AA6agR5afw8s52J5k8ANiGBZ2AJghNnge3OAhhFOjfwdj/q7FYBbe8lc2YZ8qHHjL6k9udoJs2UxHbldej8aHlNUgIU=
X-Received: by 2002:a05:6402:293:b0:43d:3936:66b0 with SMTP id
 l19-20020a056402029300b0043d393666b0mr1134525edv.404.1659606191429; Thu, 04
 Aug 2022 02:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com> <20220803185600.76rwp4o3itb2e2dn@mobilestation>
In-Reply-To: <20220803185600.76rwp4o3itb2e2dn@mobilestation>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Thu, 4 Aug 2022 10:43:00 +0100
Message-ID: <CAHyZL-ftLQNg2eTsmSXRSpHUNzNyTEt+UUGCUs2XqvRgeiWRrg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add support for enhanced SPI for Designware SPI controllers
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 3, 2022 at 7:56 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hi Sudip
>
> On Tue, Aug 02, 2022 at 06:57:44PM +0100, Sudip Mukherjee wrote:
> > Some Synopsys SSI controllers support enhanced SPI which includes
> > Dual mode, Quad mode and Octal mode. DWC_ssi includes clock stretching
> > feature in enhanced SPI modes which can be used to prevent FIFO underflow
> > and overflow conditions while transmitting or receiving the data respectively.
> > This is only tested on controller version 1.03a.
> >
> > Ben Dooks (1):
> >   spi: dw-apb-ssi: add generic 1.03a version
>
> Thanks for the patchset. It's always welcome to have a new
> functionality support. I'll have it reviewed on the next week.

Thanks Sergey. I will then wait for your review before sending a v2
with the changes Mark has suggested.

--
Regards
Sudip
