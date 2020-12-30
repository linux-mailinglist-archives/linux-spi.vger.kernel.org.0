Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17F42E7B0B
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3Q1y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 11:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgL3Q1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 11:27:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFBBC061799;
        Wed, 30 Dec 2020 08:27:13 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y19so38567123lfa.13;
        Wed, 30 Dec 2020 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z3CMC4S6zouZK2bW4zp1AT+fLNFLc4xczBndFR7DfQ0=;
        b=FzF+sK6d78ycBKK0/CuHD5ceS/Rz40J6w9iiKpTR4Vkgpex6vbdNv/Y4VjBn6VL+h0
         MrXbUhEPq4zuVSJFrPMOME66XiRjaqqbqgrAchUnv6c3dv+pWGh6aQdMLEGBF5Ox1zKg
         jIMWPurES/x2Lhck8vh7HR5jdvfgQbUwgD8EpepT//sDAm+2AhSv6DTC4a8+CdV7luvQ
         r9jvfobnpGH3V5tHzfc6dSWXwJr6m1FMhM4UJV9LAyCwyr0n+x5Dm1LDbvpUiR/AXnPw
         D55Lj1hd28apRYhlJ3vlKLxdIf+vsCzMZcBBJ72Ln8ovNEysNiUYWSSIIKc8XHJ4FvTB
         3/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z3CMC4S6zouZK2bW4zp1AT+fLNFLc4xczBndFR7DfQ0=;
        b=ms2Rzu3UEry1kPF94g0BB0le4BrdkbsVtKzbRbUMzN3GJGGhgSY09RvNtq72RUNhBQ
         uojfaqjfqK8biuh1AvinMLL03bRnkGJ9A7E2uBTAZJfEgWTt3RYt2jtJvl+VVdyhp7eQ
         1mids//CFoluQIObhUYasQoChNKWx6l9ZHeOvLc5Cb2fzxDFeOL9Cr4thiuN1PNS9Sq3
         W/gKRiaEyV7IJEoQes9lF+SaeLEHxccBRocZy49++qJSfnrcNPI1Cm6GEPUGHPG0nky4
         647bVdZaNc3mgv0/ZxBct8RJNQwKm/49WBLU9iIhd22wFpG513Pj8Bqv6smJn7D6AoKA
         txug==
X-Gm-Message-State: AOAM530VcKlda7V4JWofzlmzYGMzbcV2Rlrdi+10HEGLbJvOx8tLpnPd
        kG8qjL1cgX8uy4QANFsXVDmMf8oRQmo=
X-Google-Smtp-Source: ABdhPJzL9YkvGGLfSeQrfH5XfwB2TarbjvGCUL6Rb7LLV7Qy406cvj9HlXr8cyf4SA98Vuxtif1Vvw==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr22912107lfg.167.1609345632340;
        Wed, 30 Dec 2020 08:27:12 -0800 (PST)
Received: from [192.168.1.101] ([178.176.77.165])
        by smtp.gmail.com with ESMTPSA id e6sm5954885lfc.23.2020.12.30.08.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 08:27:11 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: rpc-if: Avoid use of C++ style comments
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, Pavel Machek <pavel@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <822dc356-4416-23a4-a460-90055dfd627a@gmail.com>
Date:   Wed, 30 Dec 2020 19:27:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230145708.28544-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/30/20 5:57 PM, Lad Prabhakar wrote:

> Replace C++ style comment with C style.

   Note that the switch to // was made following the SPI maintainer's request...

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

MBR, Sergei
