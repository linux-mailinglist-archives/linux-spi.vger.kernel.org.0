Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A04BED7E
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 23:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiBUW5o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 17:57:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiBUW5o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 17:57:44 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AE1E23;
        Mon, 21 Feb 2022 14:57:20 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so36874008ejc.7;
        Mon, 21 Feb 2022 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E05PBM3g71A4k7E9vGw3giTSxbO/J+/4n8YQAkXE/j4=;
        b=nnx0lWuKB7+M55EH4gjB6puSSMr7Vw+kyqifIywADnDKB3+xO/NVwpdqIrAvzbd8Af
         bWaIaqI6K3BXoFGo1osFrUJ2B9feX+a+tYo2/avFZTiOnfBq/RsLfnvqjmL+IZjhMeq9
         EYL2fQjw45ewUs/4Qpa4WXFdUsOMU5XiiZwN/eeBbXS//tGp7LJigArOHxku2Ch+xUQ8
         a0jfgN03LqpBNcvScqWtkK8NtSaUeuvw/PKtTofU+lkHskflH0aZRSuw7f8eVeqDIwKs
         Q9cCoCHrrk2imEdVAVoO0sKJQA/6L/HbyQ7nGBUfi7JUCONVcbiQ+3Nf0U8IkE2hCJ+7
         EgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E05PBM3g71A4k7E9vGw3giTSxbO/J+/4n8YQAkXE/j4=;
        b=gQJ2dttyP6cTIjk36QQBiN2UbZvT96afmT/CRN+5uIAZ4Y8GsOjRpHd5Rl4zXqEjNm
         rbZn85mP/zyMEpbwCFSceNZjMKQp5XKZhP7+dry29ZSJYCsZf0jjAJVOOHKA8Zkz8GpE
         IKxtQYb9WT1o8OAFbAY1Laj+9tLC08yuW7vhUrX2rTYnwkRjqG1/iKphdCASezn0+hHI
         ZXy8Zxu/5vbF6WLV+DFaPriDVxpN/+dhuQs7Oo1hbfmTQMikVU1cIgTUqKfmO+xz6WKS
         QVjMHPvfCJ6CXjHHYFKY9h+82M7f6I5ipKewPHu4LAmGS1EGuTlfJix0Er8n50QGJx5D
         nFyw==
X-Gm-Message-State: AOAM530gLOACNqWgKrbwxzHHMq70MWapiD66OfMlqtbmtobRDAFGCBef
        hbY9QCPyXIHIR8T5zzNF2+VUXw4AJWw=
X-Google-Smtp-Source: ABdhPJxkvRMSBgdvJ+9bT568jE+xIiQCMw90veoAJuQKf4gx9NP9cAIeKBPl1NME0MaxbW8TQa9/fQ==
X-Received: by 2002:a17:906:b348:b0:6cf:8cfe:d729 with SMTP id cd8-20020a170906b34800b006cf8cfed729mr17748990ejb.622.1645484238806;
        Mon, 21 Feb 2022 14:57:18 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:f82b:ace:7fd9:1c1d? (p200300ea8f4d2b00f82b0ace7fd91c1d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:f82b:ace:7fd9:1c1d])
        by smtp.googlemail.com with ESMTPSA id b3sm5580023ejl.67.2022.02.21.14.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 14:57:18 -0800 (PST)
Message-ID: <d8baa907-a8c8-17d3-e724-df490a0fff83@gmail.com>
Date:   Mon, 21 Feb 2022 23:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
 <CANiq72ko6=dYBvbRc5T7Qq_2mxRtq1NpvcV_saMbTDfz0PK1aw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CANiq72ko6=dYBvbRc5T7Qq_2mxRtq1NpvcV_saMbTDfz0PK1aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21.02.2022 23:10, Miguel Ojeda wrote:
> On Mon, Feb 21, 2022 at 9:19 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> v2:
>> - (re-)add Andreas' SoB to two patches
> 
> But those were also developed by you too, right? i.e. it should have a
> Co-developed-by too, otherwise it looks like you only handled the
> patch:
> 

Right, about half of the original code was reworked. Let's see whether and
which feedback comes for v2. If a v3 should be needed, I'll follow your
suggestion.

> ```
> Example of a patch submitted by the From: author::
> 
>         <changelog>
> 
>         Co-developed-by: First Co-Author <first@coauthor.example.org>
>         Signed-off-by: First Co-Author <first@coauthor.example.org>
>         Co-developed-by: Second Co-Author <second@coauthor.example.org>
>         Signed-off-by: Second Co-Author <second@coauthor.example.org>
>         Signed-off-by: From Author <from@author.example.org>
> ```
> 
> Cheers,
> Miguel

Heiner
