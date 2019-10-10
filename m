Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA2D207D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2019 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfJJFsg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Oct 2019 01:48:36 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39964 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJJFsg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Oct 2019 01:48:36 -0400
Received: by mail-pl1-f170.google.com with SMTP id d22so2223450pll.7;
        Wed, 09 Oct 2019 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M73eTh2IyVB2ImUoY1cyaaC83v8DNk4r7gIsheGhrG0=;
        b=o2NO/7NOyiJUrzG5T5hM3oUYqOGgKyeswjXsaRZdUPLvWgTPPwTJys3V1lLQmkBfnO
         UXXyZ2C70NbESHQbFnnqKM9LEOGK+/tlxX2MfvIao7tKlA4IwCbmsGoFJYClF4r7/zXD
         BR0djjkFJWfBLkkmiAHB9NIkW1d7goQa7DeMIL4ysZaVUo9eSbxUwEmSs403H0hZPhcB
         k/DaukaKEDslnQBJ4vf1Ck5yJyueCsXdv4lQuGorp+tUYk+JvGjRnCfXut3dr3F1lBio
         uro0J7tiAZDLrthJ5dIRmlbZKBuUTTJAK1kLQWSBwFLLnjR5qDcpY/CEM/Y1W1Onzb8/
         3IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M73eTh2IyVB2ImUoY1cyaaC83v8DNk4r7gIsheGhrG0=;
        b=rf0sbAnUC7ASOQYrG06AnioJVaNxM4xmm/fHruRjlrF8FHQEKLeEeUk/jznVktS4Cu
         uPqgTjnlnjgdOyO7Jo+rZu4qmnRkjKbM9uQYTPUyXkPRVreLgQMfhDB0o5K98aiCmiDy
         //YmGsK+12nquaLNKaU05tQzcSQFoOJHAw4lDS1qYxlI/63qdbW22MqRTzJYtq/O6RgO
         SuE8GIKQH2l2rxZS9drmxzIAq1g9JT1HKxC99Bz0kTjui1JgncmF6cmLeEWPw3+QRs3x
         vhI5fita2FKSPWiX8YR16izVb8ptJIeg2DKChLpB4FcrXthyi7GBiYpBMFx9hf+695Pt
         bNPA==
X-Gm-Message-State: APjAAAWSnWCZIkg9eIqKyoMntaHTDVh6HagXuawTs2ye0vsC7GgEAG4p
        tdhhmijO+eyBwZBpg0OGqYI=
X-Google-Smtp-Source: APXvYqyqnjbFtD0gz8TaokY4cezJLZBiOwaHWq2Wq6FW0ezA2ldw5FjwVSqQLES7VVRFHEztgKXZww==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr7333329plb.135.1570686515501;
        Wed, 09 Oct 2019 22:48:35 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id dw19sm3745090pjb.27.2019.10.09.22.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 22:48:34 -0700 (PDT)
Subject: Re: Potential NULL pointer deference in spi
To:     Yizhuo Zhai <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
Date:   Wed, 9 Oct 2019 22:48:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
> Hi All:
> 
> drivers/spi/spi.c:
> 
> The function to_spi_device() could return NULL, but some callers
> in this file does not check the return value while directly dereference
> it, which seems potentially unsafe.
> 
> Such callers include spidev_release(),  spi_dev_check(),
> driver_override_store(), etc.
> 
> 


Many of your reports are completely bogus.

I suggest you spend more time before sending such emails to very large audience
and risk being ignored at some point.

Thanks.
