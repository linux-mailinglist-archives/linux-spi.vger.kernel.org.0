Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B724A42855B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 04:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhJKC4L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 Oct 2021 22:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhJKC4K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 Oct 2021 22:56:10 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30CC061570;
        Sun, 10 Oct 2021 19:54:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w8so6005475qts.4;
        Sun, 10 Oct 2021 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rR3sNjmAm5aObe9//U8J0QR4+mtH+O6QjDXAkUaYWJs=;
        b=TAn0VNJlQGkutzsDt4fVm8vDp/MHN7Fo6TahQE7co9AXxcf6OKRcCxO07A4UOaPaq2
         jnzbb/2FnbeJku8QmMbdUo047tAlvZV3Ga0X9VA8qoP9niUxgs7Hk55lnS6j8zgh3GoN
         yWBBVME+WYO4BKDqQrGWkYCZEpUK6TkiPKbblNotMpjutKq0mU+O1Ng1Cq2s62ehHGfN
         hrPb7muTGAGEFKCd1eN4dVCfC/bKLjb9m9bCWS5mShICnp1NdAbF3UytiP8eEQtWm5AR
         GHabX8ej1j0pkIs4z68oCALzzkYCeKloPnZXRRNjAEH1rMVAxOYFR6DwLYjnDLiM/TLA
         Q6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rR3sNjmAm5aObe9//U8J0QR4+mtH+O6QjDXAkUaYWJs=;
        b=HVdAGhtiofEGfjzi5TE4Al5nEyh8u1JPTyX19YJJ3KX0DQjYNeZMkLNnzOk+nUS4Py
         kUMqoQA44atAvv9EV2/nnLykWAbxRfPhlz8/881dVGtpxoC2EPQPIB8/w8FJPlxfJSl4
         a86tsoaimnoeMlIgEngrgX2AHunT28sfEu5fpbHF6aJmjRLaHhj4mMLNTaViRcesL9/K
         TJRzvioGPhni+1KvUFTQQqbjzfeB7lpTBonX8qnwUfuCKPgl2JJlDLWL+N2DltbN/19F
         K8EKH/aXF2xFevXUZfxW5YMOtY9lydmjngNOBkeG8SdwoiW5vFBlSrTJIw9BXnwSM86M
         R5uw==
X-Gm-Message-State: AOAM530p63VPchpx/J/XAe3DMSXiwTQBAi2PIqPYlUtHexxmLK97rJKQ
        NtEeMGa57MZg4baUIV0Cu58pyJGRtog=
X-Google-Smtp-Source: ABdhPJx4b9Um0/Ijl06r1T3X7ozi+aKA1b3mlOLqPkazLCNaiV5/vlUAJf4M96dkivuAT9DH0Wu2CA==
X-Received: by 2002:a05:622a:1444:: with SMTP id v4mr12346193qtx.298.1633920850406;
        Sun, 10 Oct 2021 19:54:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:dfe0:49f0:3cb6:937e:609b:a590? ([2600:1700:dfe0:49f0:3cb6:937e:609b:a590])
        by smtp.gmail.com with ESMTPSA id b20sm3822406qtt.2.2021.10.10.19.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:54:09 -0700 (PDT)
Message-ID: <4bfb80eb-2233-46f9-5f4c-15820d7576f6@gmail.com>
Date:   Sun, 10 Oct 2021 19:54:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 3/3] spi: bcm-qspi: add support for 3-wire mode for half
 duplex transfer
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
 <20211008203603.40915-4-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211008203603.40915-4-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/8/2021 1:36 PM, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> This change configures the MSPI controller to use 3-wire interface when
> a slave device devictree nodes indicates this via the optional property.
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
