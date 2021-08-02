Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB453DD158
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhHBHk6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhHBHk5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 03:40:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BCC06175F;
        Mon,  2 Aug 2021 00:40:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u20so22795834ljo.0;
        Mon, 02 Aug 2021 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rx5q39Xw1a0JHH/JpOAv2dOieHFpmxEhCjzvGdgwxac=;
        b=O+AFu5KVOfglY6BISS0tHH7b0Xzrm+nN0tWvnQzROevDBptoTAvP/bfQ3ML7CgB3FP
         JXLxCKfbsURoiyfyg5E957Diq3HlUsYKoUOrMobARGJfZ0cdmwj8UgRWV4g7Pyco+WOw
         7+x9Va79c14LJiNX7YvRiTNzx6WCiqe+kiN32G3DJIyG3+eKM8gFabYHCxLqUUpJm1WM
         AwayYKfaZD43bCHculSQ98usthauNdeqd6qtrYV/vSdITHS0oeLf4d1+aHZOAxeYx6sO
         N/guu698a+Q7nW3iPMEgrvc/rU1RoNfM1uSyZ2jItSI9JyxndvZw1qgedRcX9cVqKE4i
         5uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rx5q39Xw1a0JHH/JpOAv2dOieHFpmxEhCjzvGdgwxac=;
        b=dtu7sDhSsDrPTm+SEVRWq+OA5cU3a3ru653GLAjOfw4yvX0E9vrn5AyQnhvJC15K1m
         ukaBXaxMQ3hscEw69U2BacDJ6c/TcbT22Uqy423MrB6hty53lfu/oVrF6+xmUVYnrHPC
         pmc6MzJGshzt3Yj21vNciOkHRuWlRuMdKW/7cg5ViFsvB1wswGvGWtXOAmSvV6r1q0Jc
         1//cp8XKu8kwkjHdVUpnIz1MdUWNml/7Uyj78zJh0JHhxz1E8WSD7l1m4vNuMFsLfHhg
         OtMrraRekt4KfmHnDLAoTUBDcIhmrmVElV8VX/aw9LYCCWPQ+ycYO9fc+TpuLShK69ic
         FnBg==
X-Gm-Message-State: AOAM530WOJyHk72TYEarCT+BqM5v5s94L/KN5xvNw3U3P0acPIDIGLcj
        R4ADP9niIvH3+a8Nm6eQnhG3kgidCwU=
X-Google-Smtp-Source: ABdhPJwfOETjLE0hCokBQk+uH4O4MCFf15UDoXoQn73CRKGh6piOwZIRGA/ufgvwUUzzhcq2Iielog==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr10158364ljn.23.1627890045395;
        Mon, 02 Aug 2021 00:40:45 -0700 (PDT)
Received: from [192.168.1.49] ([109.197.204.123])
        by smtp.gmail.com with ESMTPSA id b23sm883533lff.65.2021.08.02.00.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 00:40:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] spi: spi-ep93xx: Prepare clock before using it
To:     Mark Brown <broonie@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-3-nikita.shubin@maquefel.me>
 <20210726165105.GI4670@sirena.org.uk>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <37e15955-771f-56a8-cf8e-4342c3c2c3a3@gmail.com>
Date:   Mon, 2 Aug 2021 09:36:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726165105.GI4670@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Mark,

On 26/07/2021 18:51, Mark Brown wrote:
> On Mon, Jul 26, 2021 at 04:59:50PM +0300, Nikita Shubin wrote:
>> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>>
>> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
>> to Common Clock Framework, otherwise the following is visible:
> Acked-by: Mark Brown <broonie@kernel.org>

It looks like we didn't manage to bring the whole series as one lot to any
maintainer and two patches were applied to two different trees.
Could you please take this one to your tree as well?

>> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
>> Enabling unprepared ep93xx-spi.0
>> ...
>> Hardware name: Cirrus Logic EDB9302 Evaluation Board
>> ...
>> clk_core_enable
>> clk_core_enable_lock
>> ep93xx_spi_prepare_hardware
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Yes, I noted your comment first time and this was already stripped version
of the backtrace, but please feel free to strip it even harder if you
take the patch.

Thank you for the review,
--
Alex.
