Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9D42855A
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 04:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhJKC4K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 Oct 2021 22:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhJKC4I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 Oct 2021 22:56:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63FC061570;
        Sun, 10 Oct 2021 19:54:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c7so15327290qka.2;
        Sun, 10 Oct 2021 19:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8qtA9xFLNvi3qA1OE8Q5X8dJdUIlul07oe0HgT/zEi8=;
        b=m46o/Q1RZf+6L+OH8ejBdzFZC3cUikE+rnh+IlZ0S+BZjLbOf8RQxeH9zqOSWiCSQj
         5qmF4+2qAX080AGCV/Uu0+A0icNfUZub9jlPzbKkPvjnTcB1MXW5KyJP4QkQ75hTK1Pa
         5luZNoZ9SSVFYesyVUFfjSqcbQbSPD+gKj/E23AHeGlY1fVu7FnrDHhdqz+UcPcp+zCm
         IDIgdbS33IAzSgA8QZ5ycNUcONIFi0FruT/UJIk2kKdxtUWsKEwwpKq+GsXwasnPqkX9
         gOtd/7LHVMCe6OYmdx5QCeN9PTAmxrK962wbTLzIdOQvVjx/XORstVFjW/9iWYCQ13fU
         imAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8qtA9xFLNvi3qA1OE8Q5X8dJdUIlul07oe0HgT/zEi8=;
        b=jtqWKX/0uzuV3D9o0DGzMvPWrHnDpLkAIUmhcKO1EGlqH1pQQ4pMf7OYarImAPH5yu
         OMG+l+/TTnCUf2NLYW/XNdT5k7oJPvnyrHlnzRxZ/jpoIuWXcNiqnBbwMVm4qCA8dsky
         TG8Sg8w7EZSxab3sMSXX1imzqO4/r8lcEnxle68FsFK1fnEJol9/MnHCUiWpbY8/BXPX
         n5/1iTvUNa1eWsQ8cUJnI3WCmfhu/Fm211ZTlPQ6zBqtLd/njOpTwPzk5DwgUTHxTl5Q
         KIKaAHWY+mSuzFVsqPM1GsfmGVhEWJbySNpN3hb/9LVSoSp+WYVnCLcX0p7lkZxQBBQZ
         A3tg==
X-Gm-Message-State: AOAM530kqW9dmYey0sueRUACXBYwqv9nEPAPqe18cg1QnJeDpBv5sDlq
        PUYTfYwjD4doUmNFmBLL9qU=
X-Google-Smtp-Source: ABdhPJxA1Z53BfQOpgMfhVUx+cdHphSqDjmqhUIbzzKmDO4a9FVJY5UmSHlyLe5ODU2KhmhvC6471g==
X-Received: by 2002:a37:b403:: with SMTP id d3mr13314400qkf.174.1633920848092;
        Sun, 10 Oct 2021 19:54:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:dfe0:49f0:3cb6:937e:609b:a590? ([2600:1700:dfe0:49f0:3cb6:937e:609b:a590])
        by smtp.gmail.com with ESMTPSA id h14sm4039937qtx.69.2021.10.10.19.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 19:54:07 -0700 (PDT)
Message-ID: <30442a99-ede7-6251-ddca-8ecc577632ec@gmail.com>
Date:   Sun, 10 Oct 2021 19:54:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/3] spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu@broadcom.com>
References: <20211008203603.40915-1-kdasu.kdev@gmail.com>
 <20211008203603.40915-2-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211008203603.40915-2-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/8/2021 1:36 PM, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> Adding 32-bits and 64-bits per transfer modes using the SPCR3
> register settings provided in MSPI controller ver >= 1.5
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
